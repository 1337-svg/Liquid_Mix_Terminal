if Legit == nil then
    Legit = false
end

local NewV = Vector3.new
local NewC = CFrame.new
local AngC = CFrame.fromEulerAnglesXYZ
local LP = game.Players.LocalPlayer
local function toggleSlide(newValue)
    if newValue == true then
        LP.Character.HumanoidRootPart.Size = Vector3.new(2, 1, 1)
        LP.Character.BoundingBox.Size = Vector3.new(2, 1, 1)
        LP.Character.Humanoid.HipHeight = -1.5
    else
        LP.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
        LP.Character.BoundingBox.Size = Vector3.new(2, 2, 1)
        LP.Character.Humanoid.HipHeight = 0
    end
    LP.Character.Animate.Sliding:Fire(newValue)
end

local function doSlide(delay)
    toggleSlide(true)
    task.wait(delay)
    toggleSlide(false)
end
local Alert = getsenv(LP.PlayerScripts.CL_MAIN_GameScript).newAlert
local Multi = workspace.Multiplayer
local RS = game:GetService('RunService')

-- IMPORTANT
local CLMAIN = getsenv(LP.PlayerScripts.CL_MAIN_GameScript)
local oldalert
oldalert = hookfunction(CLMAIN.newAlert, function(...)
    warn("Alert function fired with args:", ...)
    return oldalert(...)
end)
if not getrenv().alreadystarted then
    CLMAIN.newAlert("Tool Assisted Speedrun: Executed")
    getrenv().alreadystarted = true
else
    CLMAIN.newAlert("Tool Assisted Speedrun: Queue")
end
local Animate = getsenv(LP.Character.Animate)
local Map = Multi:WaitForChild('NewMap')
local mapName = Map:WaitForChild('Settings'):GetAttribute("MapName")
local TAS = game:GetService("HttpService"):JSONDecode(readfile("CM_TAS/" .. selected_file_2 .. ".json"))
if not TAS then
    LP.Character.Humanoid.Health = 0
    LP.CharacterAdded:Wait()
else
CLMAIN.newAlert("Tool Assisted Speedrun: Queue")
repeat task.wait() until Map.Name == "Map"
local Spawn = Map:WaitForChild('Spawn')

local function SetPrimaryPart()
    local Map = game.Workspace.Multiplayer:WaitForChild("Map")
    local Part = nil
    local connections = {}
    for i,v in ipairs(Map:GetChildren()) do
        if v.Name == "Spawn" then
            v.Name = "Part"
            Part = v
            break
        end
    end
    if not Part then
        error("Unable to find 'Spawn' object")
        return
    end
    Map.PrimaryPart = Part
end

game:GetService("ReplicatedStorage").Remote.StartClientMapTimer.OnClientEvent:Wait(0.1)
local TimeStart = tick()
CLMAIN.newAlert('Tool Assisted Speedrun: Executed', Color3.fromRGB(255, 149, 62))
PlayAnim = Animate.playAnimation
Animate.playAnimation = function() end

for _, v in next, Map:GetDescendants() do
    if v.Name == 'ButtonIcon' then
        local buttonPart = v.Parent.Parent:FindFirstChildOfClass('Part')
        if buttonPart ~= nil then
            buttonPart.Size = Vector3.new(3,3,3)
        end
    end
end

--[[
local ToggleSwim = function(val)
    LP.Character.Animate.ToggleSwim:Fire(val)
end
]]
local BoundingBox = LP.Character.BoundingBox
BoundingBox.CanTouch = false

local function toggleTouch(bool)
    BoundingBox.CanTouch = bool
end

function isRandomString(str) -- basicly detects if button 99% of the time just checks if all capital
    for i = 1, #str do
        local ltr = str:sub(i, i)
        if ltr:lower() == ltr then
            return false
        end     
    end
    return true
end


local function badCheck(Thing) --  NOT walljump or NOT AIRTANK or explodingbutton hitbox :check:
    return not (Thing:FindFirstChild("_Wall") or Thing.Parent.Name ~= "AirTank" or (Thing.Name == "Part" and isRandomString(Thing.Parent.Name)))
end
local walljumpfix
walljumpfix = LP.Character.HumanoidRootPart.Touched:Connect(function(Thing)
    if badCheck(Thing) then
        toggleTouch(true)
        print("Touched:", Thing:GetFullName())
    elseif Thing.Name == "RopeStart" then
        toggleTouch(true)
        firetouchinterest(Thing, BoundingBox, 0)
    end
end)

local walljumpfix2
walljumpfix2 = LP.Character.HumanoidRootPart.TouchEnded:Connect(function(Thing)
    if badCheck(Thing) then
        toggleTouch(false)
    elseif Thing.Name == "RopeStart" then
        toggleTouch(false)
        firetouchinterest(Thing, BoundingBox, 1)
    end
end)

local function activateAnimation(CurrentAnimation)
    if CurrentAnimation and CurrentAnimation[1] then 
        PlayAnim(CurrentAnimation[1],CurrentAnimation[2],LP.Character.Humanoid)
        if CurrentAnimation[1] == "walk" then
            Animate.setAnimationSpeed(.76) 
        elseif CurrentAnimation[1] == "slide" then
            task.spawn(doSlide, 0.10)
        end
    end
end

local Offset = Spawn.Position - NewV(0, 1000, 0)
local OldFrame = 3

local Loop
local Death

Death = LP.Character.Humanoid.Changed:Connect(function(Change)
    if Change == "Health" and LP.Character.Humanoid.Health == 0 then
        Death:Disconnect()
        Loop:Disconnect()
        CLMAIN.newAlert('Tool Assisted Speedrun: Failed', Color3.new(1, 0, 0))
    end
end)

local RootPart = LP.Character.HumanoidRootPart
if Legit then
    RootPart.RootJoint.Enabled = false
end
Loop = RS.Heartbeat:Connect(function(DeltaTime)
    local NewFrame = #TAS
    local Divider = OldFrame + 60
    if Divider < NewFrame then
        NewFrame = Divider
    end
    for i = OldFrame, NewFrame do
        local CurrentInfo = TAS[i]
        if (tick() - TimeStart) < CurrentInfo.time then
            break
        elseif i >= #TAS then
            Death:Disconnect()
            Loop:Disconnect()
            toggleTouch(true)
            toggleTouch = nil
            walljumpfix:Disconnect()
            walljumpfix2:Disconnect()
            Animate.playAnimation = PlayAnim
            CLMAIN.newAlert('Tool Assisted Speedrun: Completed', Color3.new(0, 1, 0))
            CLMAIN.newAlert('discord.gg/oneclan', Color3.new(0, 1, 0))
        elseif (tick() - TimeStart) >= CurrentInfo.time then
            OldFrame = i
            local CCFrame = CurrentInfo.CCFrame
            local CCameraCFrame = CurrentInfo.CCameraCFrame
            local VVelocity = CurrentInfo.VVelocity
            local CurrentAnimation = CurrentInfo.AAnimation
            RootPart.CFrame = NewC(CCFrame[1], CCFrame[2], CCFrame[3]) * AngC(CCFrame[4], CCFrame[5], CCFrame[6]) + Offset
            --workspace.CurrentCamera.CFrame = NewC(CCameraCFrame[1], CCameraCFrame[2], CCameraCFrame[3]) * AngC(CCameraCFrame[4], CCameraCFrame[5], CCameraCFrame[6]) + Offset
            RootPart.Velocity = NewV(VVelocity[1], VVelocity[2], VVelocity[3])
            activateAnimation(CurrentAnimation)
        end
    end
end)
end
