if Legit == nil then
    Legit = false
end
local SkipMirroredMaps = {
    ["Retro Coast"] = true,
    ["Zemblanity"] = true,
    ["Northren Mill"] = true,
    ["Mysterium"] = true,
    ["Decaying Silo"] = true,
    ["Active Volcanic Mines"] = true,
    ["Rustic Jungle"] = true,
    ["Abandoned Harbour"] = true,
}
if getgenv().whatthefuckisthisyoumayaskitisaverylongvariblename then
    for _,v in ipairs(getgenv().whatthefuckisthisyoumayaskitisaverylongvariblename) do
        SkipMirroredMaps[v] = true
    end
end
local Mirrored = false
local NewV = Vector3.new
local NewC = CFrame.new
local AngC = CFrame.fromEulerAnglesXYZ
local LP = game.Players.LocalPlayer
--[[local function hookAnimation()
    repeat
        SenvAnimation = getsenv(LP.Character:WaitForChild("Animate"))
        task.wait()
    until SenvAnimation.playAnimation ~= nil
    PlayAnimation = SenvAnimation.playAnimation
    function SenvAnimation.playAnimation(a, b)
        AnimationState = {a, b}
        PlayAnimation(AnimationState[1], AnimationState[2], LP.Character.Humanoid)
    end
    print("Animation has been hooked.")
end]]
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
if not getrenv().alreadystarted then
    CLMAIN.newAlert("Tool Assisted Speedrun: Executed")
    getrenv().alreadystarted = true
else
    CLMAIN.newAlert("Tool Assisted Speedrun: Queue")
end
local Multi = workspace.Multiplayer
local Map = Multi:WaitForChild('NewMap')
local mapName = Map:WaitForChild('Settings'):GetAttribute("MapName")
local MapLoadConnection

local function checkMapLoad()
    MapLoadConnection = Map.ChildAdded:Connect(function(child)
        if child.Name == "Settings" and child:GetAttribute("MapName") == mapName then
            onMapLoaded()
            MapLoadConnection:Disconnect()
        end
    end)
end

checkMapLoad()
local Animate = getsenv(LP.Character.Animate)
local Map = Multi:WaitForChild('NewMap')
local mapName = Map:WaitForChild('Settings'):GetAttribute("MapName")
local TAS = game:GetService("HttpService"):JSONDecode(readfile("TAS/"..selected_file..".json"))
if not TAS then
    -- LP.Character.Humanoid.Health = 0
    -- LP.CharacterAdded:wait()
else
CLMAIN.newAlert("Tool Assisted Speedrun: Queue")
repeat task.wait() until Map.Name == "Map"

local HighlightPath = game:GetService("Workspace").Multiplayer.Map.Settings:GetAttribute("Highlight")

if HighlightPath then
    Mirrored = false
else
    if not SkipMirroredMaps[mapName] then
        if Map:WaitForChild('Settings'):FindFirstChild("_MirrorMap") then
            --CLMAIN.newAlert('Map is not mirrored.', Color3.fromRGB(255, 149, 5))
            Mirrored = false
        else
            --CLMAIN.newAlert('Map is mirrored, TAS will be played mirrored!', Color3.fromRGB(255, 149, 5))
            Mirrored = true
        end
    end
end

local Spawn = (function() -- new spawn finder by "tomato.txt" on discord
    local Spawn = nil

    local connections = {}
    for _,v in ipairs(Map:GetChildren()) do
        if v.Name == "Part" then
            table.insert(connections, v:GetPropertyChangedSignal("Rotation"):Connect(function()
                for _,v in ipairs(connections) do
                    v:Disconnect()
                end
                Spawn = v
            end))
        end
    end
    repeat task.wait() until Spawn
    CLMAIN.newAlert("Spawn found!", Color3.fromRGB(0, 255, 0))
    return Spawn
end)()

game:GetService("ReplicatedStorage").Remote.StartClientMapTimer.OnClientEvent:Wait(.1)
local TimeStart = tick()
CLMAIN.newAlert('Tool Assisted Speedrun: Executed', Color3.fromRGB(255, 149, 62))
PlayAnim = Animate.playAnimation
Animate.playAnimation = function() end

--[[hookAnimation() -- Hook the animation before starting TAS playback
print("Animation hooked successfully.") -- Print a message indicating successful animation hook]]

for _, v in next, Map:GetDescendants() do
    if v.Name == 'ButtonIcon' then
        local buttonPart = v.Parent.Parent:FindFirstChildOfClass('Part')
        if buttonPart ~= nil then
            buttonPart.Size = Vector3.new(4,3,4)
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
    elseif Thing.Name == "RopeStart" then
        toggleTouch(true)
    end
end)

local walljumpfix2

walljumpfix2 = LP.Character.HumanoidRootPart.TouchEnded:Connect(function(Thing)
    if badCheck(Thing) then
        toggleTouch(false)
    elseif Thing.Name == "RopeStart" then
        toggleTouch(false)
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

LP.CharacterAdded:Connect(function(character)
    if character and character:FindFirstChild("HumanoidRootPart") then
        onMapLoaded()
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
            if Legit then
                RootPart.RootJoint.Enabled = true
                LP.Character.Humanoid.Health = 0
            end
            Animate.playAnimation = PlayAnim
            CLMAIN.newAlert('TAS Run Finished!', Color3.new(0, 1, 0))
            CLMAIN.newAlert('discord.gg/oneclan', Color3.new(0, 1, 0))
        elseif (tick() - TimeStart) >= CurrentInfo.time then
            OldFrame = i
            local CCFrame = CurrentInfo.CCFrame
            local CCameraCFrame = CurrentInfo.CCameraCFrame
            local VVelocity = CurrentInfo.VVelocity
            local CurrentAnimation = CurrentInfo.AAnimation
            if Mirrored == true then
                RootPart.CFrame = NewC(CCFrame[1], CCFrame[2], -CCFrame[3]) * AngC(-3.1415927410125732, CCFrame[5], -3.1415927410125732) + Offset
                --workspace.CurrentCamera.CFrame = NewC(-CCameraCFrame[1], -CCameraCFrame[2], -CCameraCFrame[3]) * AngC(3.1415927410125732, CCameraCFrame[5], 3.1415927410125732) + Offset
            else
                RootPart.CFrame = NewC(CCFrame[1], CCFrame[2], CCFrame[3]) * AngC(CCFrame[4], CCFrame[5], CCFrame[6]) + Offset
                workspace.CurrentCamera.CFrame = NewC(CCameraCFrame[1], CCameraCFrame[2], CCameraCFrame[3]) * AngC(CCameraCFrame[4], CCameraCFrame[5], CCameraCFrame[6]) + Offset
            end
            RootPart.Velocity = NewV(VVelocity[1], VVelocity[2], VVelocity[3])
            activateAnimation(CurrentAnimation)
        end
    end
end)
end
