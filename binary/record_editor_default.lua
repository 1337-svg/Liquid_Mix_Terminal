local Keybinds = {
    AddSavestate = "One",
    RemoveSavestate = "Two",
    BackSavestate = "Three",
    GoFrameBack = "Four",
    GoFrameForward = "Five",
    SaveRun = "Six",
    UserPause = "CapsLock",
    CollisionToggler = "C",
    ResetToNormal = "Delete",
    ViewTAS = "Zero"
}

local Offset, SpawnPos, Ything, Xoff, Yoff,  Zoff
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local Alert = getsenv(game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript).newAlert
local RealRunID
repeat 
    RealRunID = math.random(1, 999)
until RealRunID ~= 666 and RealRunID ~= 14
local RunID = " "..tostring(RealRunID)

Alert("Tool Assisted Run Activated."..RunID, Color3.new(0.717647, 0, 1))
local Key = -game.ReplicatedStorage.Remote.ReqPasskey:InvokeServer()
local AnimationState = {}
local Savestates = {}
local PlayerInfo = {}
local TimePaused = 0
local Pause = true
local TimePauseHolder
local SenvAnimation
local PlayAnimation
local TimeStart
local TimeText
local GameStats
local SaveStatesCount
local FrameCount
local CapLockPause
local MapName -- add to ui later maybe ?
local AnimationHookConnection
queue_on_teleport('warn("lmao")')
local function getCurrentCFrame()
    local RealCframe
    if AnimationState[1] and AnimationState[1]:lower():match("swim") then
        RealCframe = game.Players.LocalPlayer.Character.Torso.CFrame
    else
        RealCframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
    local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = RealCframe:GetComponents()
    -- all the r's dont matter
    local fuck = CFrame.new(x - Xoff, (y - Yoff) + 1000, z - Zoff, r00, r01, r02, r10, r11, r12, r20, r21, r22)
    return fuck
end

local function ReturnPlayerInfo()
    return {
            CFrame = getCurrentCFrame(),
            CameraCFrame = workspace.CurrentCamera.CFrame,
            Velocity = LocalPlayer.Character.HumanoidRootPart.Velocity,
            Animation = AnimationState,
            Time = tick() - TimeStart - TimePaused,
    }
end

local function isRandomString(str)
    for i = 1, #str do
        local ltr = str:sub(i, i)
        if ltr:lower() == ltr then
            return false
        end     
    end
    return true
end

local function HandleThing(Interactive)
    if not isRandomString(Interactive.Name) then
        Interactive.CanCollide = not Interactive.CanCollide
        if Interactive.CanCollide == false then
            Interactive.Transparency = 0
        elseif Interactive.CanCollide == true then
            Interactive.Transparency = 1
        end
    end
end

local function SetPrimaryPart() -- new spawn finder by "_tomato." on discord
    local Map = game.Workspace.Multiplayer:WaitForChild("Map")
    local Spawn = nil
    local connections = {}
    for _,v in ipairs(Map:GetChildren()) do
        if v.Name == "Part" and v.Size.Y < 5 then
            table.insert(connections, v:GetPropertyChangedSignal("Rotation"):Connect(function()
                Spawn = v
                for _,v in ipairs(connections) do
                    v:Disconnect()
                end
            end))
        end
    end
    repeat task.wait() until Spawn
    Map.PrimaryPart = Spawn
end
local RealHUD = LocalPlayer.PlayerGui.GameGui.HUD
local OldParent = RealHUD.Parent
local HUD 
local function SetUpGui()
    RealHUD.Parent = game.ReplicatedStorage

    HUD = Instance.new("Frame")
    local Main = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local GameStats = Instance.new("Frame")
    local Ingame = Instance.new("Frame")
    local Info = Instance.new("Frame")
    local PlayerCount = Instance.new("Frame")
    local PlayerIcon = Instance.new("ImageLabel")
    local StandardGradient = Instance.new("UIGradient")
    local Count = Instance.new("TextLabel")
    local TextGradient = Instance.new("UIGradient")
    local Buttons = Instance.new("Frame")
    local Count_2 = Instance.new("TextLabel")
    local TextGradient_2 = Instance.new("UIGradient")
    local ButtonIcon = Instance.new("Frame")
    local Background = Instance.new("Frame")
    local Border = Instance.new("ImageLabel")
    local StandardGradient_2 = Instance.new("UIGradient")
    local Middle = Instance.new("ImageLabel")
    local StandardGradient_3 = Instance.new("UIGradient")
    local Air = Instance.new("Frame")
    local Count_3 = Instance.new("TextLabel")
    local TextGradient_3 = Instance.new("UIGradient")
    local Icons = Instance.new("Frame")
    local Standard = Instance.new("ImageLabel")
    local UIGradient = Instance.new("UIGradient")
    local Danger = Instance.new("ImageLabel")
    local UIGradient_2 = Instance.new("UIGradient")
    local DrainCount = Instance.new("TextLabel")
    local Time = Instance.new("Frame")
    local Current = Instance.new("Frame")
    local Count_4 = Instance.new("TextLabel")
    local TextGradient_4 = Instance.new("UIGradient")
    local TimeIcon = Instance.new("ImageLabel")
    local StandardGradient_4 = Instance.new("UIGradient")
    local Record = Instance.new("Frame")
    local Count_5 = Instance.new("TextLabel")
    local TextGradient_5 = Instance.new("UIGradient")
    local TimeIcon_2 = Instance.new("ImageLabel")
    local StandardGradient_5 = Instance.new("UIGradient")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local AirBars = Instance.new("Frame")
    local BasicBar = Instance.new("ImageLabel")
    local Percentage = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIGradient_3 = Instance.new("UIGradient")
    local Temp = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local UIGradient_4 = Instance.new("UIGradient")
    local UICorner_3 = Instance.new("UICorner")
    local UIGradient_5 = Instance.new("UIGradient")
    local TankBar = Instance.new("ImageLabel")
    local Percentage_2 = Instance.new("Frame")
    local UICorner_4 = Instance.new("UICorner")
    local UIGradient_6 = Instance.new("UIGradient")
    local Temp_2 = Instance.new("Frame")
    local UICorner_5 = Instance.new("UICorner")
    local UIGradient_7 = Instance.new("UIGradient")
    local UICorner_6 = Instance.new("UICorner")
    local AirDirection = Instance.new("ImageLabel")
    local UICorner_7 = Instance.new("UICorner")
    local UIGradient_8 = Instance.new("UIGradient")
    local MapTest = Instance.new("Frame")
    local Logo = Instance.new("ImageLabel")
    local UIListLayout_3 = Instance.new("UIListLayout")
    local Frame = Instance.new("Frame")
    local HostName = Instance.new("TextLabel")
    local ServerID = Instance.new("TextLabel")
    local UIPadding = Instance.new("UIPadding")
    local UICorner_8 = Instance.new("UICorner")
    local UIGradient_9 = Instance.new("UIGradient")
    local Stats = Instance.new("Frame")
    local XPStats = Instance.new("Frame")
    local ProgressBar = Instance.new("ImageLabel")
    local Percentage_3 = Instance.new("ImageLabel")
    local UICorner_9 = Instance.new("UICorner")
    local UIGradient_10 = Instance.new("UIGradient")
    local Frame_2 = Instance.new("Frame")
    local UICorner_10 = Instance.new("UICorner")
    local XP = Instance.new("TextLabel")
    local TextGradient_6 = Instance.new("UIGradient")
    local Icon = Instance.new("Frame")
    local Visuals = Instance.new("Frame")
    local UICorner_11 = Instance.new("UICorner")
    local UIGradient_11 = Instance.new("UIGradient")
    local Info_2 = Instance.new("TextLabel")
    local TextGradient_7 = Instance.new("UIGradient")
    local Rebirth = Instance.new("Frame")
    local Info_3 = Instance.new("TextLabel")
    local Gradient = Instance.new("ImageLabel")
    local LoginStats = Instance.new("Frame")
    local ProgressBar_2 = Instance.new("ImageLabel")
    local Percentage_4 = Instance.new("ImageLabel")
    local UICorner_12 = Instance.new("UICorner")
    local UIGradient_12 = Instance.new("UIGradient")
    local Days = Instance.new("TextLabel")
    local TextGradient_8 = Instance.new("UIGradient")
    local Icon_2 = Instance.new("Frame")
    local Visuals_2 = Instance.new("Frame")
    local UICorner_13 = Instance.new("UICorner")
    local UIGradient_13 = Instance.new("UIGradient")
    local Info_4 = Instance.new("TextLabel")
    local TextGradient_9 = Instance.new("UIGradient")
    local Rebirth_2 = Instance.new("ImageButton")
    local TextLabel = Instance.new("TextLabel")
    local TextGradient_10 = Instance.new("UIGradient")
    local BG = Instance.new("Frame")
    local Glow = Instance.new("Frame")
    local Gradient_2 = Instance.new("ImageLabel")
    local UICorner_14 = Instance.new("UICorner")
    local UIGradient_14 = Instance.new("UIGradient")
    local UICorner_15 = Instance.new("UICorner")
    local UIGradient_15 = Instance.new("UIGradient")
    local ParticleFrame = Instance.new("Frame")
    local Currency = Instance.new("TextButton")
    local CoinAmt = Instance.new("ImageLabel")
    local Amount = Instance.new("TextLabel")
    local TextGradient_11 = Instance.new("UIGradient")
    local UICorner_16 = Instance.new("UICorner")
    local UIGradient_16 = Instance.new("UIGradient")
    local GemAmt = Instance.new("ImageLabel")
    local Amount_2 = Instance.new("TextLabel")
    local TextGradient_12 = Instance.new("UIGradient")
    local UICorner_17 = Instance.new("UICorner")
    local UIGradient_17 = Instance.new("UIGradient")
    local BuyLabel = Instance.new("ImageLabel")
    local Desc = Instance.new("TextLabel")
    local TextGradient_13 = Instance.new("UIGradient")
    local UICorner_18 = Instance.new("UICorner")
    local UIGradient_18 = Instance.new("UIGradient")
    TimeText = Instance.new("TextLabel")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    SavestatesCount = Instance.new("TextLabel")
    setscriptable(SavestatesCount, "Text", true)
    local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
    FrameCount = Instance.new("TextLabel")
    local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
    local TextButton = Instance.new("TextButton")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local KeyBindFrame = Instance.new("Frame")
    local UIListLayout_4 = Instance.new("UIListLayout")
    CapLockPause = Instance.new("TextLabel")
    local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
    local SaveStateInfo = Instance.new("TextLabel")
    local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
    local RemoveSaveStateInfo = Instance.new("TextLabel")
    local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
    local GoBackSavestate = Instance.new("TextLabel")
    local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
    local GoFrameBack = Instance.new("TextLabel")
    local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
    local GoFrameForward = Instance.new("TextLabel")
    local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
    local SaveRun = Instance.new("TextLabel")
    local UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")
    local CanCollideToggle = Instance.new("TextLabel")
    local UITextSizeConstraint_11 = Instance.new("UITextSizeConstraint")
    local Resettonormal = Instance.new("TextLabel")
    local Viewtas = Instance.new("TextLabel")
    local UITextSizeConstraint_12 = Instance.new("UITextSizeConstraint")
    local UITextSizeConstraint_69 = Instance.new("UITextSizeConstraint")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local AimLock = Instance.new("TextButton")
    local Icon_3 = Instance.new("ImageLabel")
    local UICorner_19 = Instance.new("UICorner")
    local UIGradient_19 = Instance.new("UIGradient")
    local Main2 = Instance.new("Frame")
    local GameStats_2 = Instance.new("Frame")
    local Dropshadowthingy = Instance.new("Frame")
    local DropShadowHolder_2 = Instance.new("Frame")
    local DropShadow_2 = Instance.new("ImageLabel")
    local UICorner_20 = Instance.new("UICorner")
    local UICorner_21 = Instance.new("UICorner")
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
    local UICorner_22 = Instance.new("UICorner")
    local UIListLayout_5 = Instance.new("UIListLayout")
    local MapEventInfo = Instance.new("TextLabel")
    local UIGradient_20 = Instance.new("UIGradient")
    local TimeBar = Instance.new("Frame")
    local Percent = Instance.new("Frame")
    local UICorner_23 = Instance.new("UICorner")
    local UIGradient_21 = Instance.new("UIGradient")
    local UICorner_24 = Instance.new("UICorner")
    local UIGradient_22 = Instance.new("UIGradient")
    
        
    --Properties:
    HUD.Name = "HUD"
    HUD.Parent = Instance.new("ScreenGui", game:GetService("CoreGui"))
    HUD.AnchorPoint = Vector2.new(0.5, 0)
    HUD.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    HUD.BackgroundTransparency = 1.000
    HUD.BorderSizePixel = 0
    HUD.Position = UDim2.new(0.5, 0, 0.889999986, 0)
    HUD.Size = UDim2.new(1, 0, 0.0825000033, 0)
    HUD.SizeConstraint = Enum.SizeConstraint.RelativeYY
    HUD.ZIndex = 3
    
    Main.Name = "Main"
    Main.Parent = HUD
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1.000
    Main.Size = UDim2.new(1, 0, 1, 0)
    
    UIListLayout.Parent = Main
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.Padding = UDim.new(0.00999999978, 0)
    
    GameStats.Name = "GameStats"
    GameStats.Parent = Main
    GameStats.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    GameStats.BackgroundTransparency = 0.500
    GameStats.BorderColor3 = Color3.fromRGB(27, 42, 53)
    GameStats.BorderSizePixel = 0
    GameStats.LayoutOrder = 3
    GameStats.Position = UDim2.new(0.330083579, 0, 0.178413421, 0)
    GameStats.Size = UDim2.new(0, 348, 0, 73)
    
    Ingame.Name = "Ingame"
    Ingame.Parent = GameStats
    Ingame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Ingame.BackgroundTransparency = 1.000
    Ingame.Size = UDim2.new(1, 0, 1, 0)
    Ingame.Visible = false
    
    Info.Name = "Info"
    Info.Parent = Ingame
    Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Info.BackgroundTransparency = 1.000
    Info.Size = UDim2.new(1, 0, 0.899999976, 0)
    
    PlayerCount.Name = "PlayerCount"
    PlayerCount.Parent = Info
    PlayerCount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerCount.BackgroundTransparency = 1.000
    PlayerCount.LayoutOrder = 3
    PlayerCount.Position = UDim2.new(0.675000012, 0, 0.25, 0)
    PlayerCount.Size = UDim2.new(0.224999994, 0, 1, 0)
    PlayerCount.ZIndex = 2
    
    PlayerIcon.Name = "PlayerIcon"
    PlayerIcon.Parent = PlayerCount
    PlayerIcon.AnchorPoint = Vector2.new(0, 0.5)
    PlayerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerIcon.BackgroundTransparency = 1.000
    PlayerIcon.Position = UDim2.new(0, 0, 0.5, 0)
    PlayerIcon.Size = UDim2.new(0.5, 0, 0.899999976, 0)
    PlayerIcon.ZIndex = 2
    PlayerIcon.Image = "rbxassetid://4078197699"
    PlayerIcon.ScaleType = Enum.ScaleType.Fit
    
    StandardGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(195, 235, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    StandardGradient.Rotation = 270
    StandardGradient.Name = "StandardGradient"
    StandardGradient.Parent = PlayerIcon
    
    Count.Name = "Count"
    Count.Parent = PlayerCount
    Count.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Count.BackgroundTransparency = 1.000
    Count.Position = UDim2.new(0.5, 0, 0, 0)
    Count.Size = UDim2.new(0.5, 0, 1, 0)
    Count.ZIndex = 2
    Count.Text = "0"
    Count.TextColor3 = Color3.fromRGB(255, 255, 255)
    Count.TextScaled = true
    Count.TextSize = 14.000
    Count.TextStrokeTransparency = 0.650
    Count.TextWrapped = true
    
    TextGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient.Rotation = 90
    TextGradient.Name = "TextGradient"
    TextGradient.Parent = Count
    
    Buttons.Name = "Buttons"
    Buttons.Parent = Info
    Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Buttons.BackgroundTransparency = 1.000
    Buttons.LayoutOrder = 4
    Buttons.Position = UDim2.new(0.824999988, 0, 0.25, 0)
    Buttons.Size = UDim2.new(0.224999994, 0, 1, 0)
    Buttons.ZIndex = 2
    
    Count_2.Name = "Count"
    Count_2.Parent = Buttons
    Count_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Count_2.BackgroundTransparency = 1.000
    Count_2.Position = UDim2.new(0.5, 0, 0, 0)
    Count_2.Size = UDim2.new(0.5, 0, 1, 0)
    Count_2.ZIndex = 2
    Count_2.Text = "0"
    Count_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Count_2.TextScaled = true
    Count_2.TextSize = 14.000
    Count_2.TextStrokeTransparency = 0.650
    Count_2.TextWrapped = true
    
    TextGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_2.Rotation = 90
    TextGradient_2.Name = "TextGradient"
    TextGradient_2.Parent = Count_2
    
    ButtonIcon.Name = "ButtonIcon"
    ButtonIcon.Parent = Buttons
    ButtonIcon.AnchorPoint = Vector2.new(0, 0.5)
    ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonIcon.BackgroundTransparency = 1.000
    ButtonIcon.Position = UDim2.new(0, 0, 0.5, 0)
    ButtonIcon.Size = UDim2.new(0.5, 0, 0.75, 0)
    ButtonIcon.ZIndex = 2
    
    Background.Name = "Background"
    Background.Parent = ButtonIcon
    Background.AnchorPoint = Vector2.new(0.5, 0.5)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.600
    Background.BorderSizePixel = 0
    Background.Position = UDim2.new(0.5, 0, 0.5, 0)
    Background.Size = UDim2.new(0.829999983, 0, 0.829999983, 0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Background.ZIndex = 3
    
    Border.Name = "Border"
    Border.Parent = ButtonIcon
    Border.AnchorPoint = Vector2.new(0.5, 0.5)
    Border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Border.BackgroundTransparency = 1.000
    Border.Position = UDim2.new(0.5, 0, 0.5, 0)
    Border.Size = UDim2.new(1, 0, 1, 0)
    Border.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Border.ZIndex = 3
    Border.Image = "rbxassetid://2192707592"
    
    StandardGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(195, 235, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    StandardGradient_2.Rotation = 270
    StandardGradient_2.Name = "StandardGradient"
    StandardGradient_2.Parent = Border
    
    Middle.Name = "Middle"
    Middle.Parent = ButtonIcon
    Middle.AnchorPoint = Vector2.new(0.5, 0.5)
    Middle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Middle.BackgroundTransparency = 1.000
    Middle.Position = UDim2.new(0.5, 0, 0.5, 0)
    Middle.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
    Middle.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Middle.ZIndex = 3
    Middle.Image = "rbxassetid://2192707404"
    Middle.ImageRectSize = Vector2.new(128, 128)
    
    StandardGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(195, 235, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    StandardGradient_3.Rotation = 270
    StandardGradient_3.Name = "StandardGradient"
    StandardGradient_3.Parent = Middle
    
    Air.Name = "Air"
    Air.Parent = Info
    Air.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Air.BackgroundTransparency = 1.000
    Air.LayoutOrder = 1
    Air.Size = UDim2.new(0.300000012, 0, 1, 0)
    
    Count_3.Name = "Count"
    Count_3.Parent = Air
    Count_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Count_3.BackgroundTransparency = 1.000
    Count_3.BorderSizePixel = 0
    Count_3.LayoutOrder = 1
    Count_3.Position = UDim2.new(0.400000006, 0, 0, 0)
    Count_3.Size = UDim2.new(0.600000024, 0, 1, 0)
    Count_3.Text = "100"
    Count_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Count_3.TextScaled = true
    Count_3.TextSize = 14.000
    Count_3.TextStrokeTransparency = 0.650
    Count_3.TextWrapped = true
    
    TextGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_3.Rotation = 90
    TextGradient_3.Name = "TextGradient"
    TextGradient_3.Parent = Count_3
    
    Icons.Name = "Icons"
    Icons.Parent = Air
    Icons.AnchorPoint = Vector2.new(0, 0.5)
    Icons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icons.BackgroundTransparency = 1.000
    Icons.Position = UDim2.new(0, 0, 0.5, 0)
    Icons.Size = UDim2.new(0.400000006, 0, 1, 0)
    
    Standard.Name = "Standard"
    Standard.Parent = Icons
    Standard.AnchorPoint = Vector2.new(0, 0.5)
    Standard.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Standard.BackgroundTransparency = 1.000
    Standard.Position = UDim2.new(0, 0, 0.5, 0)
    Standard.Size = UDim2.new(1, 0, 0.899999976, 0)
    Standard.ZIndex = 2
    Standard.Image = "rbxassetid://7028899420"
    Standard.ScaleType = Enum.ScaleType.Fit
    
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 168, 200)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    UIGradient.Rotation = 270
    UIGradient.Parent = Standard
    
    Danger.Name = "Danger"
    Danger.Parent = Icons
    Danger.AnchorPoint = Vector2.new(0, 0.5)
    Danger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Danger.BackgroundTransparency = 1.000
    Danger.Position = UDim2.new(0, 0, 0.5, 0)
    Danger.Size = UDim2.new(1, 0, 0.899999976, 0)
    Danger.Visible = false
    Danger.ZIndex = 2
    Danger.Image = "rbxassetid://7028944853"
    Danger.ScaleType = Enum.ScaleType.Fit
    
    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(230, 75, 59)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(211, 84, 0))}
    UIGradient_2.Rotation = 270
    UIGradient_2.Parent = Danger
    
    DrainCount.Name = "DrainCount"
    DrainCount.Parent = Icons
    DrainCount.AnchorPoint = Vector2.new(0.5, 0)
    DrainCount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DrainCount.BackgroundTransparency = 1.000
    DrainCount.Position = UDim2.new(0.5, 0, 0, 0)
    DrainCount.Size = UDim2.new(0.980000019, 0, 1, 0)
    DrainCount.Visible = false
    DrainCount.ZIndex = 3
    DrainCount.Text = ""
    DrainCount.TextColor3 = Color3.fromRGB(255, 255, 255)
    DrainCount.TextScaled = true
    DrainCount.TextSize = 14.000
    DrainCount.TextStrokeTransparency = 0.000
    DrainCount.TextWrapped = true
    
    Time.Name = "Time"
    Time.Parent = Info
    Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Time.BackgroundTransparency = 1.000
    Time.LayoutOrder = 4
    Time.Size = UDim2.new(0.25, 0, 1, 0)
    
    Current.Name = "Current"
    Current.Parent = Time
    Current.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Current.BackgroundTransparency = 1.000
    Current.LayoutOrder = 2
    Current.Size = UDim2.new(1, 0, 0.5, 0)
    
    Count_4.Name = "Count"
    Count_4.Parent = Current
    Count_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Count_4.BackgroundTransparency = 1.000
    Count_4.LayoutOrder = 2
    Count_4.Position = UDim2.new(0.200000003, 0, 0, 0)
    Count_4.Size = UDim2.new(0.800000012, 0, 1, 0)
    Count_4.ZIndex = 2
    Count_4.Text = "0:00.000"
    Count_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Count_4.TextScaled = true
    Count_4.TextSize = 14.000
    Count_4.TextStrokeTransparency = 0.625
    Count_4.TextWrapped = true
    Count_4.TextXAlignment = Enum.TextXAlignment.Left
    
    TextGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_4.Rotation = 90
    TextGradient_4.Name = "TextGradient"
    TextGradient_4.Parent = Count_4
    
    TimeIcon.Name = "TimeIcon"
    TimeIcon.Parent = Current
    TimeIcon.AnchorPoint = Vector2.new(0, 0.5)
    TimeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeIcon.BackgroundTransparency = 1.000
    TimeIcon.Position = UDim2.new(0, 0, 0.5, 0)
    TimeIcon.Size = UDim2.new(0.200000003, 0, 1, 0)
    TimeIcon.ZIndex = 2
    TimeIcon.Image = "rbxassetid://7028993786"
    TimeIcon.ScaleType = Enum.ScaleType.Fit
    
    StandardGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(195, 235, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    StandardGradient_4.Rotation = 270
    StandardGradient_4.Name = "StandardGradient"
    StandardGradient_4.Parent = TimeIcon
    
    Record.Name = "Record"
    Record.Parent = Time
    Record.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Record.BackgroundTransparency = 1.000
    Record.LayoutOrder = 2
    Record.Position = UDim2.new(0, 0, 0.5, 0)
    Record.Size = UDim2.new(1, 0, 0.5, 0)
    
    Count_5.Name = "Count"
    Count_5.Parent = Record
    Count_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Count_5.BackgroundTransparency = 1.000
    Count_5.LayoutOrder = 2
    Count_5.Position = UDim2.new(0.200000003, 0, 0, 0)
    Count_5.Size = UDim2.new(0.800000012, 0, 1, 0)
    Count_5.ZIndex = 2
    Count_5.Text = "0:00.000"
    Count_5.TextColor3 = Color3.fromRGB(241, 219, 128)
    Count_5.TextScaled = true
    Count_5.TextSize = 14.000
    Count_5.TextStrokeTransparency = 0.625
    Count_5.TextWrapped = true
    Count_5.TextXAlignment = Enum.TextXAlignment.Left
    
    TextGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_5.Rotation = 90
    TextGradient_5.Name = "TextGradient"
    TextGradient_5.Parent = Count_5
    
    TimeIcon_2.Name = "TimeIcon"
    TimeIcon_2.Parent = Record
    TimeIcon_2.AnchorPoint = Vector2.new(0, 0.5)
    TimeIcon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeIcon_2.BackgroundTransparency = 1.000
    TimeIcon_2.Position = UDim2.new(0, 0, 0.5, 0)
    TimeIcon_2.Size = UDim2.new(0.200000003, 0, 1, 0)
    TimeIcon_2.ZIndex = 2
    TimeIcon_2.Image = "rbxassetid://7028993786"
    TimeIcon_2.ImageColor3 = Color3.fromRGB(241, 219, 128)
    TimeIcon_2.ScaleType = Enum.ScaleType.Fit
    
    StandardGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(195, 235, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
    StandardGradient_5.Rotation = 270
    StandardGradient_5.Name = "StandardGradient"
    StandardGradient_5.Parent = TimeIcon_2
    
    UIListLayout_2.Parent = Info
    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    
    AirBars.Name = "AirBars"
    AirBars.Parent = Ingame
    AirBars.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AirBars.BackgroundTransparency = 1.000
    AirBars.ClipsDescendants = true
    AirBars.Position = UDim2.new(0, 0, 0.875, 0)
    AirBars.Size = UDim2.new(1, 0, 0.125, 0)
    
    BasicBar.Name = "BasicBar"
    BasicBar.Parent = AirBars
    BasicBar.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    BasicBar.BorderSizePixel = 0
    BasicBar.ClipsDescendants = true
    BasicBar.Size = UDim2.new(1, 0, 1, 0)
    
    Percentage.Name = "Percentage"
    Percentage.Parent = BasicBar
    Percentage.BackgroundColor3 = Color3.fromRGB(0, 174, 255)
    Percentage.BorderSizePixel = 0
    Percentage.ClipsDescendants = true
    Percentage.Size = UDim2.new(1, 0, 1, 0)
    Percentage.ZIndex = 2
    
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = Percentage
    
    UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_3.Rotation = 90
    UIGradient_3.Parent = Percentage
    
    Temp.Name = "Temp"
    Temp.Parent = BasicBar
    Temp.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    Temp.BorderSizePixel = 0
    Temp.ClipsDescendants = true
    Temp.Size = UDim2.new(1, 0, 1, 0)
    
    UICorner_2.CornerRadius = UDim.new(0, 3)
    UICorner_2.Parent = Temp
    
    UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(65, 65, 65))}
    UIGradient_4.Rotation = 90
    UIGradient_4.Parent = Temp
    
    UICorner_3.CornerRadius = UDim.new(0, 3)
    UICorner_3.Parent = BasicBar
    
    UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_5.Rotation = -90
    UIGradient_5.Parent = BasicBar
    
    TankBar.Name = "TankBar"
    TankBar.Parent = AirBars
    TankBar.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    TankBar.BackgroundTransparency = 1.000
    TankBar.BorderSizePixel = 0
    TankBar.ClipsDescendants = true
    TankBar.Size = UDim2.new(1, 0, 1, 0)
    TankBar.ZIndex = 2
    
    Percentage_2.Name = "Percentage"
    Percentage_2.Parent = TankBar
    Percentage_2.BackgroundColor3 = Color3.fromRGB(128, 213, 255)
    Percentage_2.BorderSizePixel = 0
    Percentage_2.ClipsDescendants = true
    Percentage_2.Size = UDim2.new(0, 0, 1, 0)
    Percentage_2.ZIndex = 2
    
    UICorner_4.CornerRadius = UDim.new(0, 3)
    UICorner_4.Parent = Percentage_2
    
    UIGradient_6.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(65, 65, 65))}
    UIGradient_6.Rotation = 90
    UIGradient_6.Parent = Percentage_2
    
    Temp_2.Name = "Temp"
    Temp_2.Parent = TankBar
    Temp_2.BackgroundColor3 = Color3.fromRGB(150, 43, 33)
    Temp_2.BorderSizePixel = 0
    Temp_2.ClipsDescendants = true
    Temp_2.Size = UDim2.new(0, 0, 1, 0)
    
    UICorner_5.CornerRadius = UDim.new(0, 3)
    UICorner_5.Parent = Temp_2
    
    UIGradient_7.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_7.Rotation = 90
    UIGradient_7.Parent = Temp_2
    
    UICorner_6.CornerRadius = UDim.new(0, 3)
    UICorner_6.Parent = TankBar
    
    AirDirection.Name = "AirDirection"
    AirDirection.Parent = AirBars
    AirDirection.AnchorPoint = Vector2.new(0.5, 0.5)
    AirDirection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AirDirection.BackgroundTransparency = 1.000
    AirDirection.Position = UDim2.new(0.5, 0, 0.5, 0)
    AirDirection.Rotation = 270.000
    AirDirection.Size = UDim2.new(1, 0, 66.5999985, 0)
    AirDirection.SizeConstraint = Enum.SizeConstraint.RelativeYY
    AirDirection.Visible = false
    AirDirection.ZIndex = 2
    AirDirection.Image = "rbxassetid://6399401493"
    AirDirection.ImageColor3 = Color3.fromRGB(0, 0, 0)
    AirDirection.ImageTransparency = 0.625
    AirDirection.ScaleType = Enum.ScaleType.Tile
    AirDirection.TileSize = UDim2.new(1, 0, 0.0250000004, 0)
    
    UICorner_7.CornerRadius = UDim.new(0, 3)
    UICorner_7.Parent = AirDirection
    
    UIGradient_8.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.40), NumberSequenceKeypoint.new(1.00, 0.40)}
    UIGradient_8.Parent = AirDirection
    
    MapTest.Name = "MapTest"
    MapTest.Parent = GameStats
    MapTest.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MapTest.BackgroundTransparency = 1.000
    MapTest.Size = UDim2.new(1, 0, 1, 0)
    MapTest.Visible = false
    
    Logo.Name = "Logo"
    Logo.Parent = MapTest
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0, 0, 0.0250000004, 0)
    Logo.Size = UDim2.new(0.550000012, 0, 0.949999988, 0)
    Logo.Image = "http://www.roblox.com/asset/?id=12481454381"
    Logo.ScaleType = Enum.ScaleType.Fit
    
    UIListLayout_3.Parent = MapTest
    UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
    
    Frame.Parent = MapTest
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1.000
    Frame.Size = UDim2.new(0.449999988, 0, 1, 0)
    
    HostName.Name = "HostName"
    HostName.Parent = Frame
    HostName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HostName.BackgroundTransparency = 1.000
    HostName.LayoutOrder = 1
    HostName.Size = UDim2.new(1, 0, 0.400000006, 0)
    HostName.Text = "Host: coolzak35"
    HostName.TextColor3 = Color3.fromRGB(255, 255, 255)
    HostName.TextScaled = true
    HostName.TextSize = 14.000
    HostName.TextStrokeTransparency = 0.650
    HostName.TextWrapped = true
    HostName.TextXAlignment = Enum.TextXAlignment.Left
    
    ServerID.Name = "ServerID"
    ServerID.Parent = Frame
    ServerID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServerID.BackgroundTransparency = 1.000
    ServerID.LayoutOrder = 1
    ServerID.Position = UDim2.new(0, 0, 0.400000006, 0)
    ServerID.Size = UDim2.new(1, 0, 0.600000024, 0)
    ServerID.Text = "ID: GR1FFN"
    ServerID.TextColor3 = Color3.fromRGB(255, 255, 255)
    ServerID.TextScaled = true
    ServerID.TextSize = 14.000
    ServerID.TextStrokeTransparency = 0.650
    ServerID.TextWrapped = true
    ServerID.TextXAlignment = Enum.TextXAlignment.Left
    
    UIPadding.Parent = Frame
    UIPadding.PaddingLeft = UDim.new(0.0199999996, 0)
    
    UICorner_8.CornerRadius = UDim.new(0, 9)
    UICorner_8.Parent = GameStats
    
    UIGradient_9.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_9.Rotation = -90
    UIGradient_9.Parent = GameStats
    
    Stats.Name = "Stats"
    Stats.Parent = GameStats
    Stats.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Stats.BackgroundTransparency = 1.000
    Stats.Size = UDim2.new(1, 0, 1, 0)
    Stats.Visible = false
    
    XPStats.Name = "XPStats"
    XPStats.Parent = Stats
    XPStats.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    XPStats.BackgroundTransparency = 1.000
    XPStats.BorderSizePixel = 0
    XPStats.ClipsDescendants = true
    XPStats.Position = UDim2.new(0.00499999989, 0, 0.0375000015, 0)
    XPStats.Size = UDim2.new(0.639999986, 0, 0.449999988, 0)
    
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = XPStats
    ProgressBar.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    ProgressBar.BackgroundTransparency = 1.000
    ProgressBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ClipsDescendants = true
    ProgressBar.Position = UDim2.new(0.100000001, 0, 0.0500000007, 0)
    ProgressBar.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    ProgressBar.ImageColor3 = Color3.fromRGB(0, 0, 0)
    
    Percentage_3.Name = "Percentage"
    Percentage_3.Parent = ProgressBar
    Percentage_3.BackgroundColor3 = Color3.fromRGB(241, 219, 128)
    Percentage_3.BorderSizePixel = 0
    Percentage_3.Size = UDim2.new(0.5, 0, 1, 0)
    Percentage_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
    
    UICorner_9.CornerRadius = UDim.new(0, 3)
    UICorner_9.Parent = Percentage_3
    
    UIGradient_10.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_10.Rotation = -90
    UIGradient_10.Parent = Percentage_3
    
    Frame_2.Parent = ProgressBar
    Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BackgroundTransparency = 0.500
    Frame_2.BorderSizePixel = 0
    Frame_2.Size = UDim2.new(1, 0, 1, 0)
    Frame_2.Visible = false
    
    UICorner_10.CornerRadius = UDim.new(0, 3)
    UICorner_10.Parent = ProgressBar
    
    XP.Name = "XP"
    XP.Parent = XPStats
    XP.AnchorPoint = Vector2.new(0, 0.5)
    XP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    XP.BackgroundTransparency = 1.000
    XP.Position = UDim2.new(0.980000019, 0, 0.5, 0)
    XP.Size = UDim2.new(-0.75, 0, 0.899999976, 0)
    XP.ZIndex = 2
    XP.Text = "???/??? XP"
    XP.TextColor3 = Color3.fromRGB(255, 255, 255)
    XP.TextScaled = true
    XP.TextSize = 14.000
    XP.TextStrokeTransparency = 0.650
    XP.TextWrapped = true
    XP.TextXAlignment = Enum.TextXAlignment.Right
    
    TextGradient_6.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_6.Rotation = 90
    TextGradient_6.Name = "TextGradient"
    TextGradient_6.Parent = XP
    
    Icon.Name = "Icon"
    Icon.Parent = XPStats
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1.000
    Icon.BorderSizePixel = 0
    Icon.Size = UDim2.new(0.150000006, 0, 1, 0)
    Icon.ZIndex = 2
    
    Visuals.Name = "Visuals"
    Visuals.Parent = Icon
    Visuals.BackgroundColor3 = Color3.fromRGB(241, 219, 128)
    Visuals.BorderSizePixel = 0
    Visuals.Size = UDim2.new(1, 0, 1, 0)
    
    UICorner_11.CornerRadius = UDim.new(0, 3)
    UICorner_11.Parent = Visuals
    
    UIGradient_11.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_11.Rotation = 90
    UIGradient_11.Parent = Visuals
    
    Info_2.Name = "Info"
    Info_2.Parent = Icon
    Info_2.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
    Info_2.BackgroundTransparency = 1.000
    Info_2.BorderColor3 = Color3.fromRGB(44, 62, 80)
    Info_2.BorderSizePixel = 0
    Info_2.Position = UDim2.new(0.100000001, 0, 0, 0)
    Info_2.Size = UDim2.new(0.899999976, 0, 1, 0)
    Info_2.ZIndex = 3
    Info_2.Text = "??"
    Info_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Info_2.TextScaled = true
    Info_2.TextSize = 14.000
    Info_2.TextStrokeTransparency = 0.300
    Info_2.TextWrapped = true
    Info_2.TextXAlignment = Enum.TextXAlignment.Left
    
    TextGradient_7.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_7.Rotation = 90
    TextGradient_7.Name = "TextGradient"
    TextGradient_7.Parent = Info_2
    
    Rebirth.Name = "Rebirth"
    Rebirth.Parent = XPStats
    Rebirth.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Rebirth.BackgroundTransparency = 1.000
    Rebirth.Position = UDim2.new(0.125, 0, 0.0500000007, 0)
    Rebirth.Size = UDim2.new(0.875, 0, 0.899999976, 0)
    Rebirth.Visible = false
    
    Info_3.Name = "Info"
    Info_3.Parent = Rebirth
    Info_3.AnchorPoint = Vector2.new(0.5, 0)
    Info_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Info_3.BackgroundTransparency = 1.000
    Info_3.ClipsDescendants = true
    Info_3.Position = UDim2.new(0.5, 0, 0, 0)
    Info_3.Size = UDim2.new(0.939999998, 0, 1, 0)
    Info_3.ZIndex = 2
    Info_3.Text = "x?"
    Info_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Info_3.TextScaled = true
    Info_3.TextSize = 14.000
    Info_3.TextStrokeTransparency = 0.650
    Info_3.TextWrapped = true
    Info_3.TextXAlignment = Enum.TextXAlignment.Left
    
    Gradient.Name = "Gradient"
    Gradient.Parent = Rebirth
    Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Gradient.BackgroundTransparency = 1.000
    Gradient.Size = UDim2.new(1, 0, 1, 0)
    Gradient.Image = "rbxassetid://1463504275"
    Gradient.ImageColor3 = Color3.fromRGB(0, 128, 51)
    Gradient.ImageTransparency = 0.500
    
    LoginStats.Name = "LoginStats"
    LoginStats.Parent = Stats
    LoginStats.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoginStats.BackgroundTransparency = 1.000
    LoginStats.ClipsDescendants = true
    LoginStats.Position = UDim2.new(0.00499999989, 0, 0.512499988, 0)
    LoginStats.Size = UDim2.new(0.639999986, 0, 0.449999988, 0)
    
    ProgressBar_2.Name = "ProgressBar"
    ProgressBar_2.Parent = LoginStats
    ProgressBar_2.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    ProgressBar_2.BackgroundTransparency = 1.000
    ProgressBar_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ProgressBar_2.BorderSizePixel = 0
    ProgressBar_2.ClipsDescendants = true
    ProgressBar_2.Position = UDim2.new(0.349999994, 0, 0.0500000007, 0)
    ProgressBar_2.Size = UDim2.new(0.649999976, 0, 0.899999976, 0)
    ProgressBar_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    
    Percentage_4.Name = "Percentage"
    Percentage_4.Parent = ProgressBar_2
    Percentage_4.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    Percentage_4.BorderSizePixel = 0
    Percentage_4.Size = UDim2.new(0.5, 0, 1, 0)
    Percentage_4.ImageColor3 = Color3.fromRGB(0, 0, 0)
    
    UICorner_12.CornerRadius = UDim.new(0, 3)
    UICorner_12.Parent = Percentage_4
    
    UIGradient_12.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_12.Rotation = -90
    UIGradient_12.Parent = Percentage_4
    
    Days.Name = "Days"
    Days.Parent = LoginStats
    Days.AnchorPoint = Vector2.new(0, 0.5)
    Days.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Days.BackgroundTransparency = 1.000
    Days.Position = UDim2.new(0.980000019, 0, 0.5, 0)
    Days.Size = UDim2.new(-0.560000002, 0, 0.899999976, 0)
    Days.ZIndex = 2
    Days.Text = "?/? Days"
    Days.TextColor3 = Color3.fromRGB(255, 255, 255)
    Days.TextScaled = true
    Days.TextSize = 14.000
    Days.TextStrokeTransparency = 0.650
    Days.TextWrapped = true
    Days.TextXAlignment = Enum.TextXAlignment.Right
    
    TextGradient_8.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_8.Rotation = 90
    TextGradient_8.Name = "TextGradient"
    TextGradient_8.Parent = Days
    
    Icon_2.Name = "Icon"
    Icon_2.Parent = LoginStats
    Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon_2.BackgroundTransparency = 1.000
    Icon_2.BorderSizePixel = 0
    Icon_2.Size = UDim2.new(0.400000006, 0, 1, 0)
    Icon_2.ZIndex = 2
    
    Visuals_2.Name = "Visuals"
    Visuals_2.Parent = Icon_2
    Visuals_2.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    Visuals_2.BorderSizePixel = 0
    Visuals_2.Size = UDim2.new(1, 0, 1, 0)
    
    UICorner_13.CornerRadius = UDim.new(0, 3)
    UICorner_13.Parent = Visuals_2
    
    UIGradient_13.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_13.Rotation = 90
    UIGradient_13.Parent = Visuals_2
    
    Info_4.Name = "Info"
    Info_4.Parent = Icon_2
    Info_4.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
    Info_4.BackgroundTransparency = 1.000
    Info_4.BorderColor3 = Color3.fromRGB(44, 62, 80)
    Info_4.BorderSizePixel = 0
    Info_4.Position = UDim2.new(0.0500000007, 0, 0, 0)
    Info_4.Size = UDim2.new(0.899999976, 0, 1, 0)
    Info_4.ZIndex = 3
    Info_4.Text = "Next: ??"
    Info_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Info_4.TextScaled = true
    Info_4.TextSize = 14.000
    Info_4.TextStrokeTransparency = 0.300
    Info_4.TextWrapped = true
    Info_4.TextXAlignment = Enum.TextXAlignment.Left
    
    TextGradient_9.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_9.Rotation = 90
    TextGradient_9.Name = "TextGradient"
    TextGradient_9.Parent = Info_4
    
    Rebirth_2.Name = "Rebirth"
    Rebirth_2.Parent = Stats
    Rebirth_2.Active = false
    Rebirth_2.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
    Rebirth_2.BackgroundTransparency = 1.000
    Rebirth_2.ClipsDescendants = true
    Rebirth_2.Position = UDim2.new(0.00499999989, 0, 0.0379999988, 0)
    Rebirth_2.Size = UDim2.new(0.639999986, 0, 0.449999988, 0)
    Rebirth_2.Visible = false
    Rebirth_2.ZIndex = 10
    
    TextLabel.Parent = Rebirth_2
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.ZIndex = 2
    TextLabel.Text = "Rebirth"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextStrokeTransparency = 0.450
    TextLabel.TextWrapped = true
    
    TextGradient_10.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_10.Rotation = 90
    TextGradient_10.Name = "TextGradient"
    TextGradient_10.Parent = TextLabel
    
    BG.Name = "BG"
    BG.Parent = Rebirth_2
    BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BG.BackgroundTransparency = 1.000
    BG.ClipsDescendants = true
    BG.Size = UDim2.new(1, 0, 1, 0)
    
    Glow.Name = "Glow"
    Glow.Parent = BG
    Glow.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
    Glow.BorderSizePixel = 0
    Glow.ClipsDescendants = true
    Glow.Size = UDim2.new(1, 0, 1, 0)
    
    Gradient_2.Name = "Gradient"
    Gradient_2.Parent = Glow
    Gradient_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Gradient_2.BackgroundTransparency = 1.000
    Gradient_2.Size = UDim2.new(0.5, 0, 1, 0)
    Gradient_2.Image = "rbxassetid://1463504275"
    Gradient_2.ImageColor3 = Color3.fromRGB(39, 174, 96)
    
    UICorner_14.CornerRadius = UDim.new(0, 3)
    UICorner_14.Parent = Gradient_2
    
    UIGradient_14.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_14.Rotation = 90
    UIGradient_14.Parent = Gradient_2
    
    UICorner_15.CornerRadius = UDim.new(0, 3)
    UICorner_15.Parent = Glow
    
    UIGradient_15.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_15.Rotation = 90
    UIGradient_15.Parent = Glow
    
    ParticleFrame.Name = "ParticleFrame"
    ParticleFrame.Parent = Rebirth_2
    ParticleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ParticleFrame.BackgroundTransparency = 1.000
    ParticleFrame.BorderSizePixel = 0
    ParticleFrame.ClipsDescendants = true
    ParticleFrame.Size = UDim2.new(1, 0, 1, 0)
    
    Currency.Name = "Currency"
    Currency.Parent = Stats
    Currency.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Currency.BackgroundTransparency = 1.000
    Currency.Position = UDim2.new(0.649999976, 0, 0, 0)
    Currency.Size = UDim2.new(0.349999994, 0, 1, 0)
    Currency.Text = ""
    Currency.TextColor3 = Color3.fromRGB(0, 0, 0)
    Currency.TextSize = 14.000
    
    CoinAmt.Name = "CoinAmt"
    CoinAmt.Parent = Currency
    CoinAmt.AnchorPoint = Vector2.new(0.5, 0)
    CoinAmt.BackgroundColor3 = Color3.fromRGB(241, 219, 128)
    CoinAmt.BackgroundTransparency = 0.500
    CoinAmt.BorderSizePixel = 0
    CoinAmt.Position = UDim2.new(0.25, 0, 0.0375000015, 0)
    CoinAmt.Size = UDim2.new(0.474999994, 0, 0.449999988, 0)
    CoinAmt.ZIndex = 2
    CoinAmt.Image = "rbxassetid://636634945"
    CoinAmt.ImageColor3 = Color3.fromRGB(197, 197, 197)
    CoinAmt.ScaleType = Enum.ScaleType.Crop
    
    Amount.Name = "Amount"
    Amount.Parent = CoinAmt
    Amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Amount.BackgroundTransparency = 1.000
    Amount.Size = UDim2.new(1, 0, 1, 0)
    Amount.ZIndex = 2
    Amount.Text = "#"
    Amount.TextColor3 = Color3.fromRGB(241, 219, 128)
    Amount.TextScaled = true
    Amount.TextSize = 14.000
    Amount.TextStrokeTransparency = 0.325
    Amount.TextWrapped = true
    
    TextGradient_11.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_11.Rotation = 90
    TextGradient_11.Name = "TextGradient"
    TextGradient_11.Parent = Amount
    
    UICorner_16.CornerRadius = UDim.new(0, 3)
    UICorner_16.Parent = CoinAmt
    
    UIGradient_16.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_16.Rotation = 90
    UIGradient_16.Parent = CoinAmt
    
    GemAmt.Name = "GemAmt"
    GemAmt.Parent = Currency
    GemAmt.AnchorPoint = Vector2.new(0.5, 0)
    GemAmt.BackgroundColor3 = Color3.fromRGB(56, 154, 219)
    GemAmt.BackgroundTransparency = 0.500
    GemAmt.BorderSizePixel = 0
    GemAmt.Position = UDim2.new(0.75, 0, 0.0375000015, 0)
    GemAmt.Size = UDim2.new(0.474999994, 0, 0.449999988, 0)
    GemAmt.ZIndex = 2
    GemAmt.Image = "rbxassetid://636677159"
    GemAmt.ImageColor3 = Color3.fromRGB(196, 196, 196)
    GemAmt.ScaleType = Enum.ScaleType.Crop
    
    Amount_2.Name = "Amount"
    Amount_2.Parent = GemAmt
    Amount_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Amount_2.BackgroundTransparency = 1.000
    Amount_2.Size = UDim2.new(1, 0, 1, 0)
    Amount_2.ZIndex = 2
    Amount_2.Text = "#"
    Amount_2.TextColor3 = Color3.fromRGB(135, 186, 219)
    Amount_2.TextScaled = true
    Amount_2.TextSize = 14.000
    Amount_2.TextStrokeTransparency = 0.325
    Amount_2.TextWrapped = true
    
    TextGradient_12.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_12.Rotation = 90
    TextGradient_12.Name = "TextGradient"
    TextGradient_12.Parent = Amount_2
    
    UICorner_17.CornerRadius = UDim.new(0, 3)
    UICorner_17.Parent = GemAmt
    
    UIGradient_17.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_17.Rotation = 90
    UIGradient_17.Parent = GemAmt
    
    BuyLabel.Name = "BuyLabel"
    BuyLabel.Parent = Currency
    BuyLabel.AnchorPoint = Vector2.new(0.5, 0)
    BuyLabel.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    BuyLabel.BorderSizePixel = 0
    BuyLabel.Position = UDim2.new(0.5, 0, 0.512499988, 0)
    BuyLabel.Size = UDim2.new(0.975000024, 0, 0.449999988, 0)
    BuyLabel.Image = "rbxassetid://636923942"
    BuyLabel.ImageTransparency = 0.500
    BuyLabel.ScaleType = Enum.ScaleType.Crop
    
    Desc.Name = "Desc"
    Desc.Parent = BuyLabel
    Desc.AnchorPoint = Vector2.new(0, 0.5)
    Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Desc.BackgroundTransparency = 1.000
    Desc.Position = UDim2.new(0, 0, 0.5, 0)
    Desc.Size = UDim2.new(1, 0, 0.949999988, 0)
    Desc.Text = "Buy Currency"
    Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    Desc.TextScaled = true
    Desc.TextSize = 14.000
    Desc.TextStrokeTransparency = 0.325
    Desc.TextWrapped = true
    
    TextGradient_13.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 195, 195))}
    TextGradient_13.Rotation = 90
    TextGradient_13.Name = "TextGradient"
    TextGradient_13.Parent = Desc
    
    UICorner_18.CornerRadius = UDim.new(0, 3)
    UICorner_18.Parent = BuyLabel
    
    UIGradient_18.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_18.Rotation = 90
    UIGradient_18.Parent = BuyLabel
    
    TimeText.Name = "TimeText"
    TimeText.Parent = GameStats
    TimeText.BackgroundTransparency = 1.000
    TimeText.Position = UDim2.new(0.017283421, 0, 0.162744388, 0)
    TimeText.Size = UDim2.new(0.5, 0, 0.699999988, 0)
    TimeText.Font = Enum.Font.Highway
    TimeText.Text = "0:00.000"
    TimeText.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    TimeText.TextScaled = true
    TimeText.TextSize = 45.000
    TimeText.TextWrapped = true
    
    UITextSizeConstraint.Parent = TimeText
    UITextSizeConstraint.MaxTextSize = 45
    
    SavestatesCount.Name = "SavestatesCount"
    SavestatesCount.Parent = GameStats
    SavestatesCount.BackgroundTransparency = 1.000
    SavestatesCount.Position = UDim2.new(0, 190, 0, 0)
    SavestatesCount.Size = UDim2.new(0, 149, 0, 33)
    SavestatesCount.Font = Enum.Font.Highway
    SavestatesCount.Text = "Savestates 0"
    SavestatesCount.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    SavestatesCount.TextScaled = true
    SavestatesCount.TextSize = 22.000
    SavestatesCount.TextWrapped = true
    
    UITextSizeConstraint_2.Parent = SavestatesCount
    UITextSizeConstraint_2.MaxTextSize = 22
    
    FrameCount.Name = "FrameCount"
    FrameCount.Parent = GameStats
    FrameCount.BackgroundTransparency = 1.000
    FrameCount.Position = UDim2.new(0, 190, 0, 20)
    FrameCount.Size = UDim2.new(0, 149, 0, 33)
    FrameCount.Font = Enum.Font.Highway
    FrameCount.Text = "Frames 0"
    FrameCount.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    FrameCount.TextScaled = true
    FrameCount.TextSize = 22.000
    FrameCount.TextWrapped = true
    
    UITextSizeConstraint_3.Parent = FrameCount
    UITextSizeConstraint_3.MaxTextSize = 22
    
    setscriptable(TextButton, "Text", true)
    TextButton.Parent = GameStats
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.BackgroundTransparency = 1.000
    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BorderSizePixel = 0
    TextButton.Position = UDim2.new(0, 190, 0, 42)
    TextButton.Size = UDim2.new(0, 149, 0, 33)
    TextButton.Font = Enum.Font.Highway
    TextButton.Text = "Show Keybinds"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextSize = 20.000
    
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = GameStats
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 0
    
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 47, 1, 47)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.500
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    KeyBindFrame.Name = "KeyBindFrame"
    KeyBindFrame.Parent = Main
    KeyBindFrame.Active = true
    KeyBindFrame.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    KeyBindFrame.BackgroundTransparency = 1.000
    KeyBindFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    KeyBindFrame.BorderSizePixel = 0
    KeyBindFrame.LayoutOrder = 3
    KeyBindFrame.Position = UDim2.new(0.548381984, 0, -2.41520619, 0)
    KeyBindFrame.Size = UDim2.new(-0.0219492037, 278, 3.51520572, 0)
    KeyBindFrame.Visible = false
    
    UIListLayout_4.Parent = KeyBindFrame
    UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_4.Padding = UDim.new(0, -4)
    
    CapLockPause.Name = "CapLockPause"
    CapLockPause.Parent = KeyBindFrame
    CapLockPause.BackgroundTransparency = 1.000
    CapLockPause.Position = UDim2.new(-0.0113395872, 3, 2.30704487e-07, 0)
    CapLockPause.Size = UDim2.new(1, 0, 0.112999998, 0)
    CapLockPause.Font = Enum.Font.Highway
    CapLockPause.Text = "CapLocks : Paused"
    CapLockPause.TextColor3 = Color3.fromRGB(255, 255, 0)
    CapLockPause.TextScaled = true
    CapLockPause.TextSize = 18.000
    CapLockPause.TextWrapped = true
    
    UITextSizeConstraint_4.Parent = CapLockPause
    UITextSizeConstraint_4.MaxTextSize = 18
    
    SaveStateInfo.Name = "SaveStateInfo"
    SaveStateInfo.Parent = KeyBindFrame
    SaveStateInfo.BackgroundTransparency = 1.000
    SaveStateInfo.Position = UDim2.new(0, 0, 0.114372902, 0)
    SaveStateInfo.Size = UDim2.new(1, 0, 0.112999998, 0)
    SaveStateInfo.Font = Enum.Font.Highway
    SaveStateInfo.Text = "One : Add a Savestate"
    SaveStateInfo.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    SaveStateInfo.TextScaled = true
    SaveStateInfo.TextSize = 18.000
    SaveStateInfo.TextWrapped = true
    
    UITextSizeConstraint_5.Parent = SaveStateInfo
    UITextSizeConstraint_5.MaxTextSize = 18
    
    RemoveSaveStateInfo.Name = "RemoveSaveStateInfo"
    RemoveSaveStateInfo.Parent = KeyBindFrame
    RemoveSaveStateInfo.BackgroundTransparency = 1.000
    RemoveSaveStateInfo.Position = UDim2.new(0, 0, 0.228745103, 0)
    RemoveSaveStateInfo.Size = UDim2.new(1, 0, 0.112999998, 0)
    RemoveSaveStateInfo.Font = Enum.Font.Highway
    RemoveSaveStateInfo.Text = "Two : Remove a Savestate"
    RemoveSaveStateInfo.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    RemoveSaveStateInfo.TextScaled = true
    RemoveSaveStateInfo.TextSize = 18.000
    RemoveSaveStateInfo.TextWrapped = true
    
    UITextSizeConstraint_6.Parent = RemoveSaveStateInfo
    UITextSizeConstraint_6.MaxTextSize = 18
    
    GoBackSavestate.Name = "GoBackSavestate"
    GoBackSavestate.Parent = KeyBindFrame
    GoBackSavestate.BackgroundTransparency = 1.000
    GoBackSavestate.Position = UDim2.new(0, 0, 0.343117774, 0)
    GoBackSavestate.Size = UDim2.new(1, 0, 0.112999998, 0)
    GoBackSavestate.Font = Enum.Font.Highway
    GoBackSavestate.Text = "Three : Go To Last SaveState"
    GoBackSavestate.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    GoBackSavestate.TextScaled = true
    GoBackSavestate.TextSize = 18.000
    GoBackSavestate.TextWrapped = true
    
    UITextSizeConstraint_7.Parent = GoBackSavestate
    UITextSizeConstraint_7.MaxTextSize = 18
    
    GoFrameBack.Name = "GoFrameBack"
    GoFrameBack.Parent = KeyBindFrame
    GoFrameBack.BackgroundTransparency = 1.000
    GoFrameBack.Position = UDim2.new(0, 0, 0.457489997, 0)
    GoFrameBack.Size = UDim2.new(1, 0, 0.112999998, 0)
    GoFrameBack.Font = Enum.Font.Highway
    GoFrameBack.Text = "Four : Go Back a Frame"
    GoFrameBack.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    GoFrameBack.TextScaled = true
    GoFrameBack.TextSize = 18.000
    GoFrameBack.TextWrapped = true
    
    UITextSizeConstraint_8.Parent = GoFrameBack
    UITextSizeConstraint_8.MaxTextSize = 18
    
    GoFrameForward.Name = "GoFrameForward"
    GoFrameForward.Parent = KeyBindFrame
    GoFrameForward.BackgroundTransparency = 1.000
    GoFrameForward.Position = UDim2.new(0, 0, 0.571862638, 0)
    GoFrameForward.Size = UDim2.new(1, 0, 0.112999998, 0)
    GoFrameForward.Font = Enum.Font.Highway
    GoFrameForward.Text = "Five : Go a Frame Forward"
    GoFrameForward.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    GoFrameForward.TextScaled = true
    GoFrameForward.TextSize = 18.000
    GoFrameForward.TextWrapped = true
    
    UITextSizeConstraint_9.Parent = GoFrameForward
    UITextSizeConstraint_9.MaxTextSize = 18
    
    SaveRun.Name = "SaveRun"
    SaveRun.Parent = KeyBindFrame
    SaveRun.BackgroundTransparency = 1.000
    SaveRun.Position = UDim2.new(-0.00755972462, 0, 0.767311811, 0)
    SaveRun.Size = UDim2.new(1, 0, 0.112999998, 0)
    SaveRun.Font = Enum.Font.Highway
    SaveRun.Text = "Six : SaveRun"
    SaveRun.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    SaveRun.TextScaled = true
    SaveRun.TextSize = 18.000
    SaveRun.TextWrapped = true
    
    UITextSizeConstraint_10.Parent = SaveRun
    UITextSizeConstraint_10.MaxTextSize = 18
    
    Viewtas.Name = "Viewtas"
    Viewtas.Parent = KeyBindFrame
    Viewtas.BackgroundTransparency = 1.000
    Viewtas.Position = UDim2.new(0, 0, 0.914980233, 0)
    Viewtas.Size = UDim2.new(1, 0, 0.112999998, 0)
    Viewtas.Font = Enum.Font.Highway
    Viewtas.Text = "Zero: View TAS"
    Viewtas.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    Viewtas.TextScaled = true
    Viewtas.TextSize = 18.000
    Viewtas.TextWrapped = true
    
    UITextSizeConstraint_69.Parent = Viewtas
    UITextSizeConstraint_69.MaxTextSize = 18

    CanCollideToggle.Name = "CanCollideToggle"
    CanCollideToggle.Parent = KeyBindFrame
    CanCollideToggle.BackgroundTransparency = 1.000
    CanCollideToggle.Position = UDim2.new(0, 0, 0.881716669, 0)
    CanCollideToggle.Size = UDim2.new(1, 0, 0.112817235, 0)
    CanCollideToggle.Font = Enum.Font.Highway
    CanCollideToggle.Text = "C : CanCollide Toggle"
    CanCollideToggle.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    CanCollideToggle.TextScaled = true
    CanCollideToggle.TextSize = 18.000
    CanCollideToggle.TextWrapped = true
    
    UITextSizeConstraint_11.Parent = CanCollideToggle
    UITextSizeConstraint_11.MaxTextSize = 18
    
    Resettonormal.Name = "Reset to normal"
    Resettonormal.Parent = KeyBindFrame
    Resettonormal.BackgroundTransparency = 1.000
    Resettonormal.Position = UDim2.new(0, 0, 0.914980233, 0)
    Resettonormal.Size = UDim2.new(1, 0, 0.112999998, 0)
    Resettonormal.Font = Enum.Font.Highway
    Resettonormal.Text = "Delete: Stop Creating"
    Resettonormal.TextColor3 = Color3.fromRGB(65025, 65025, 65025)
    Resettonormal.TextScaled = true
    Resettonormal.TextSize = 18.000
    Resettonormal.TextWrapped = true
    
    UITextSizeConstraint_12.Parent = Resettonormal
    UITextSizeConstraint_12.MaxTextSize = 18

    UIAspectRatioConstraint.Parent = KeyBindFrame
    
    AimLock.Name = "AimLock"
    AimLock.Parent = Main
    AimLock.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    AimLock.LayoutOrder = 4
    AimLock.Position = UDim2.new(1.00999999, 0, 0, 0)
    AimLock.Size = UDim2.new(1, 0, 1, 0)
    AimLock.SizeConstraint = Enum.SizeConstraint.RelativeYY
    AimLock.Visible = false
    AimLock.Text = ""
    AimLock.TextColor3 = Color3.fromRGB(0, 0, 0)
    AimLock.TextSize = 14.000
    AimLock.TextWrapped = true
    
    Icon_3.Name = "Icon"
    Icon_3.Parent = AimLock
    Icon_3.AnchorPoint = Vector2.new(0, 0.5)
    Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon_3.BackgroundTransparency = 1.000
    Icon_3.Position = UDim2.new(0, 0, 0.5, 0)
    Icon_3.Size = UDim2.new(1, 0, 0.899999976, 0)
    Icon_3.Image = "rbxassetid://2192707592"
    Icon_3.ScaleType = Enum.ScaleType.Fit
    
    UICorner_19.CornerRadius = UDim.new(0, 3)
    UICorner_19.Parent = AimLock
    
    UIGradient_19.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_19.Rotation = 90
    UIGradient_19.Parent = AimLock
    
    Main2.Name = "Main2"
    Main2.Parent = HUD
    Main2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main2.BackgroundTransparency = 1.000
    Main2.Size = UDim2.new(1, 0, 1, 0)
    Main2.ZIndex = -1
    
    GameStats_2.Name = "GameStats"
    GameStats_2.Parent = Main2
    GameStats_2.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    GameStats_2.BackgroundTransparency = 1.000
    GameStats_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
    GameStats_2.BorderSizePixel = 0
    GameStats_2.LayoutOrder = 3
    GameStats_2.Position = UDim2.new(0.330083579, 0, 0.178413421, 0)
    GameStats_2.Size = UDim2.new(0, 348, 0, 73)
    
    Dropshadowthingy.Name = "Dropshadowthingy"
    Dropshadowthingy.Parent = Main2
    Dropshadowthingy.Active = true
    Dropshadowthingy.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    Dropshadowthingy.BackgroundTransparency = 0.500
    Dropshadowthingy.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Dropshadowthingy.BorderSizePixel = 0
    Dropshadowthingy.LayoutOrder = 3
    Dropshadowthingy.Position = UDim2.new(0, 602, 0, -165)
    Dropshadowthingy.Size = UDim2.new(-0.0219999999, 278, 3.41499996, 0)
    Dropshadowthingy.Visible = false
    Dropshadowthingy.ZIndex = -2
    
    DropShadowHolder_2.Name = "DropShadowHolder"
    DropShadowHolder_2.Parent = Dropshadowthingy
    DropShadowHolder_2.BackgroundTransparency = 1.000
    DropShadowHolder_2.BorderSizePixel = 0
    DropShadowHolder_2.Position = UDim2.new(-4.49821499e-07, 0, -0.0830525681, 0)
    DropShadowHolder_2.Size = UDim2.new(1.00852144, 0, 1.08305275, 0)
    DropShadowHolder_2.ZIndex = 0
    
    DropShadow_2.Name = "DropShadow"
    DropShadow_2.Parent = DropShadowHolder_2
    DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow_2.BackgroundTransparency = 1.000
    DropShadow_2.BorderSizePixel = 0
    DropShadow_2.Position = UDim2.new(0.497877091, 0, 0.535654724, 0)
    DropShadow_2.Size = UDim2.new(1.19575405, 0, 1.08791792, 0)
    DropShadow_2.ZIndex = 0
    DropShadow_2.Image = "rbxassetid://6015897843"
    DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow_2.ImageTransparency = 0.500
    DropShadow_2.ScaleType = Enum.ScaleType.Slice
    DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)
    
    UICorner_20.CornerRadius = UDim.new(0, 9)
    UICorner_20.Parent = DropShadow_2
    
    UICorner_21.CornerRadius = UDim.new(0, 9)
    UICorner_21.Parent = DropShadowHolder_2
    
    UIAspectRatioConstraint_2.Parent = Dropshadowthingy
    UIAspectRatioConstraint_2.AspectRatio = 0.975
    
    UICorner_22.CornerRadius = UDim.new(0, 9)
    UICorner_22.Parent = Dropshadowthingy
    
    UIListLayout_5.Parent = Main2
    UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout_5.Padding = UDim.new(0.00999999978, 0)
    
    MapEventInfo.Name = "MapEventInfo"
    MapEventInfo.Parent = HUD
    MapEventInfo.AnchorPoint = Vector2.new(0.5, 1)
    MapEventInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MapEventInfo.BackgroundTransparency = 1.000
    MapEventInfo.Position = UDim2.new(0.5, 0, -0.100000001, 0)
    MapEventInfo.Size = UDim2.new(1.20000005, 0, 0, 0)
    MapEventInfo.Text = ""
    MapEventInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    MapEventInfo.TextScaled = true
    MapEventInfo.TextSize = 14.000
    MapEventInfo.TextStrokeTransparency = 0.625
    MapEventInfo.TextWrapped = true
    
    UIGradient_20.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(184, 184, 184))}
    UIGradient_20.Rotation = 90
    UIGradient_20.Parent = MapEventInfo
    
    TimeBar.Name = "TimeBar"
    TimeBar.Parent = HUD
    TimeBar.AnchorPoint = Vector2.new(0, 0.5)
    TimeBar.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
    TimeBar.BorderSizePixel = 0
    TimeBar.Position = UDim2.new(0, 0, 1.14999998, 0)
    TimeBar.Size = UDim2.new(1, 0, 0.150000006, 0)
    TimeBar.Visible = false
    
    Percent.Name = "Percent"
    Percent.Parent = TimeBar
    Percent.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
    Percent.BorderSizePixel = 0
    Percent.Size = UDim2.new(0, 0, 1, 0)
    
    UICorner_23.CornerRadius = UDim.new(0, 3)
    UICorner_23.Parent = Percent
    
    UIGradient_21.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_21.Rotation = 90
    UIGradient_21.Parent = Percent
    
    UICorner_24.CornerRadius = UDim.new(0, 3)
    UICorner_24.Parent = TimeBar
    
    UIGradient_22.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(0.05, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.95, Color3.fromRGB(126, 126, 126)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(63, 63, 63))}
    UIGradient_22.Rotation = 90
    UIGradient_22.Parent = TimeBar
    
    -- Scripts:
    
    local frame = TextButton.Parent.Parent.KeyBindFrame
    local frame2 = TextButton.Parent.Parent.Parent.Main2.Dropshadowthingy
    
    TextButton.Activated:Connect(function()
        frame.Visible = not frame.Visible
        frame2.Visible = not frame2.Visible
        if frame.Visible then
            TextButton.Text = "Hide Keybinds"
        else
            TextButton.Text = "Show Keybinds"
        end
    end)
    print("pro")
    local Clone = UIListLayout_5:Clone()
    local VeryParent = UIListLayout_5.Parent
    UIListLayout_5:Destroy()
    task.wait()
    Clone.Parent = VeryParent
end

local function hookAnimation()
    repeat
        SenvAnimation = getsenv(LocalPlayer.Character:WaitForChild("Animate"))
        task.wait()
    until SenvAnimation.playAnimation ~= nil
    PlayAnimation = SenvAnimation.playAnimation
    SenvAnimation.playAnimation = function(a,b)
        if not Pause then
            AnimationState = {a,b}
            PlayAnimation(AnimationState[1],AnimationState[2], LocalPlayer.Character.Humanoid)
        end
    end
    if PlayAnimation == nil then
        print("the animation script is f*cked"..RunID)
    end
    print("Updated animation hook values"..RunID)
end

local Map
local function SetUpMap()
    local CurrentInfo
    function game.ReplicatedStorage.Remote.ReqCharVars.OnClientInvoke() return {} end
    function game.ReplicatedStorage.Remote.FetchPos.OnClientInvoke() return CFrame.new() end
    SetPrimaryPart()
    MapName = game.Workspace.Multiplayer.Map.Settings:GetAttribute("MapName")
    print(MapName..RunID)
    Map = game.Workspace.Multiplayer.Map:Clone()
    Map.Parent = game.Workspace
    --Map:MoveTo(Vector3.new(0,1000,0))
    SpawnPos = Map.PrimaryPart.Position 
    Xoff, Yoff, Zoff = SpawnPos.X, SpawnPos.Y, SpawnPos.Z
    Offset = CFrame.new(Xoff, Yoff, Zoff)
    LocalPlayer.Character.Head:Destroy()
    LocalPlayer.CharacterAdded:Wait()
    LocalPlayer.Character:WaitForChild("Humanoid")
    LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    ReplicatedStorage.Remote.RemoveWaiting:FireServer(Key)
    LocalPlayer.Character.Humanoid.WalkSpeed = 0
    LocalPlayer.Character.Humanoid.JumpPower = 0
    task.wait(0.5)
    LocalPlayer.Character.Humanoid.WalkSpeed = 0
    LocalPlayer.Character.Humanoid.JumpPower = 0
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Map.PrimaryPart.Position) + Vector3.new(0,Map.PrimaryPart.Size.Y/2,0) + Vector3.new(0,LocalPlayer.Character.HumanoidRootPart.Size.Y/2,0) + Vector3.new(0,LocalPlayer.Character["Left Leg"].Size.Y,0)
    task.wait(0.5)
    LocalPlayer.Character.HumanoidRootPart.Anchored = true
    LocalPlayer.Character.Humanoid.WalkSpeed = 20
    LocalPlayer.Character.Humanoid.JumpPower = 50
    table.insert(Savestates,{{
        CFrame = getCurrentCFrame(),
        CameraCFrame = game.Workspace.CurrentCamera.CFrame * Offset,
        Velocity = Vector3.new(0,0,0),
        Animation = {"idle",0},
        Time = 0
    }})
    SetUpGui()
    TimePauseHolder = tick()
    TimeStart = tick()
    hookAnimation()
    AnimationHookConnection = LocalPlayer.CharacterAdded:Connect(function(char)
        local animate = char:WaitForChild("Animate")
        if animate.Enabled == true then
            hookAnimation()
        end
    end)
    task.wait(2)
    for _, v in ipairs(Map:GetDescendants()) do
        if v.ClassName == "ObjectValue" then
            local Interactive = v.Parent
            if not Interactive.ClassName == "Model" then
                xpcall(HandleThing, function()end, Interactive)
            elseif Interactive.ClassName == "Model" then
                for _, Interactive in ipairs(Interactive:GetDescendants()) do
                    xpcall(HandleThing, function()end, Interactive)
                end
            end
        end
    end
    for _, v in ipairs(Map:GetDescendants()) do
        if isRandomString(v.Name) then 
            local Children = (function()
                local parts = {}
                for _, huh in ipairs(v:GetChildren()) do
                    if huh:IsA("BasePart") then
                        table.insert(parts, huh)
                    end
                end
                return parts
            end)()
            local Hitbox = Children[2]
            if Hitbox and Hitbox:IsA("BasePart") and isRandomString(Hitbox.Name) then
                local selectbox = Instance.new("SelectionBox", Hitbox)
                Hitbox.Color = Color3.fromRGB(255,140,0)

                selectbox.Adornee = Hitbox
                selectbox.Color3 = Color3.fromRGB(255,140,0)

                getgenv().delayy = false
                Hitbox.Touched:Connect(function(part)
                    if delayy == false then
                        Alert("Button Touched!",Color3.fromRGB(255,140,0))
                        delayy = true
                        wait(1)
                        delayy = false
                    end
                end)
            end
        end
    end
    game.Workspace.Multiplayer.Map:Destroy()
    print("Finished setting up map"..RunID)
end

local function UpdSavestatesGUI()
    SavestatesCount.Text = "Savestates "..tostring(#Savestates)
end
local function SetTimeGui()
    pcall(function()
        local TimePlayed = tick() - TimeStart - TimePaused
        local m = math.floor(TimePlayed / 60)
        local s = math.floor(TimePlayed % 60)
        local ms = math.floor((TimePlayed * 1000) % 1000)
        m = tostring(m)
        s = tostring(s)
        ms = tostring(ms)
        for i=1, 2 do if #ms < 3 then ms = '0' .. ms end end
        for i=1, 1 do if #s < 2 then s = '0' .. s end end
        TimeText.Text = m .. ":" .. s .. ":" .. ms
    end)
end
local function UserPause()
    Pause = not Pause
    if Pause == true then
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
        TimeText.TextColor3 = Color3.fromRGB(255, 255, 0)
        TimePauseHolder = tick()

        CapLockPause.Text = "CapsLock : Paused"
        CapLockPause.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
        TimeText.TextColor3 = Color3.fromRGB(255,255,255)
        TimePaused = TimePaused + tick() - TimePauseHolder

        CapLockPause.Text = "CapsLock : Unpaused"
        CapLockPause.TextColor3 = Color3.fromRGB(255,255,255)
    end
end
local function BackSavestate()
    pcall(function()
    local InfoState = Savestates[#Savestates][#Savestates[#Savestates]]
    if InfoState then
        PlayerInfo = {}
        Pause = true
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
        TimeText.TextColor3 = Color3.fromRGB(255, 255, 0) --  Ything = SpawnPos + Vector3.new(0, 1000, 0)
        LocalPlayer.Character.HumanoidRootPart.CFrame = InfoState.CFrame + Vector3.new(Xoff, Yoff - 1000, Zoff)
        LocalPlayer.Character.HumanoidRootPart.Velocity = InfoState.Velocity
        game.Workspace.CurrentCamera.CFrame = InfoState.CameraCFrame
        TimePauseHolder = tick()
        TimeStart = tick() - InfoState.Time
        TimePaused = 0
        PlayAnimation(InfoState.Animation[1],InfoState.Animation[2],LocalPlayer.Character.Humanoid)
        if InfoState.Animation[1] == "walk" then
            SenvAnimation.setAnimationSpeed(.76)
        end
        SetTimeGui()
    end
    end)
end
local function UpdFramesGUI()
    FrameCount.Text = "Frames "..tostring(#PlayerInfo)
end
local function AddSavestate()
    Alert("Added Savestate",Color3.fromRGB(0, 255, 0),1)
    table.insert(Savestates,PlayerInfo)
    PlayerInfo = {}
end
local function RemoveSavestate()
    if #Savestates > 1 then
        Alert("Removed Savestate",Color3.fromRGB(0, 255, 0),1)
        table.remove(Savestates)
        BackSavestate()
    else
        Alert("No Savestate",Color3.fromRGB(255, 0, 0),1)
    end
end
local function CollisionToggler()
    local MouseTarget = game.Players.LocalPlayer:GetMouse().Target
    MouseTarget.CanCollide = not MouseTarget.CanCollide
    if MouseTarget.CanCollide then
        MouseTarget.Transparency = 0
    else
        MouseTarget.Transparency = 0.8
    end
end

-- beginning of fram forward
local isFrameForwardHeld = false
local FrameForwardLoopThread

local function GoForwardFrame()
    if Pause then
        UserPause()
        for i = 1, 2 do
            RunService.Heartbeat:Wait()
        end
        UserPause()
    end
end

local function FrameForwardLoop()
    while isFrameForwardHeld do
        GoForwardFrame()
        wait(.1) 
    end
end

local function FrameForwardStart()
    if not isFrameForwardHeld then
        isFrameForwardHeld = true
        FrameForwardLoopThread = task.spawn(FrameForwardLoop)
    end
end

local function FrameForwardStop()
    if isFrameForwardHeld then
        isFrameForwardHeld = false
        if FrameForwardLoopThread then
            FrameForwardLoopThread:cancel()
        end
    end
end
--End of Frame forward

-- beginning of frame back
local isFrameBackHeld = false
local FrameBackLoopThread

local function GoBackFrame()
    if LocalPlayer.Character then
        local InfoState = PlayerInfo[#PlayerInfo - 1]
        if not InfoState then
            InfoState = Savestates[#Savestates][#Savestates[#Savestates] - 1]
        elseif not Pause then
            UserPause()
        end
        LocalPlayer.Character.HumanoidRootPart.CFrame = InfoState.CFrame + Vector3.new(Xoff, Yoff - 1000, Zoff)
        LocalPlayer.Character.HumanoidRootPart.Velocity = InfoState.Velocity
        game.Workspace.CurrentCamera.CFrame = InfoState.CameraCFrame
        TimePauseHolder = tick()
        TimeStart = tick() - InfoState.Time
        TimePaused = 0
        PlayAnimation(InfoState.Animation[1], InfoState.Animation[2], LocalPlayer.Character.Humanoid)
        if InfoState.Animation[1] == "walk" then
            SenvAnimation.setAnimationSpeed(.76)
        end
        SetTimeGui()
        PlayerInfo[#PlayerInfo] = nil
    end
end

local function FrameBackStart()
    isFrameBackHeld = true
    GoBackFrame()
    while task.wait(.05) and isFrameBackHeld do
        GoBackFrame()
    end
end

local function FrameForwardStart()
    isFrameForwardHeld = true
    GoForwardFrame()
    while task.wait(.05) and isFrameForwardHeld do
        GoForwardFrame()
    end
end

-- end of frame back
local ViewingTAS = false
local function ViewTAS(TAS)
    ViewingTAS = true
    local NewV = Vector3.new
    local NewC = CFrame.new
    local AngC = CFrame.fromEulerAnglesXYZ
    local LP = game.Players.LocalPlayer
    local CurrentCamera = workspace.CurrentCamera
    local Animate = SenvAnimation
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
    local RS = game:GetService('RunService')
    local Spawn = Map.PrimaryPart
    local PlayAnim = PlayAnimation
    local BoundingBox = LP.Character.BoundingBox
    BoundingBox.CanTouch = false
    local function toggleTouch(bool)
        BoundingBox.CanTouch = bool
    end
    local function isRandomString(str)
        for i = 1, #str do
            local ltr = str:sub(i, i)
            if ltr:lower() == ltr then
                return false
            end     
        end
        return true
    end
    local function badCheck(Thing)
        local Parent = Thing.Parent
        if not Thing:FindFirstChild("_Wall") then
            if Parent and not (Thing.Name == "Part" and isRandomString(Parent.Name)) then
                if Parent.Name == "AirTank" then
                    return true
                end
                return true
            end
            return true
        end
        return false
    end
    local walljumpfix
    local walljumpfix2
    walljumpfix = LP.Character.HumanoidRootPart.Touched:Connect(function(Thing)
        if badCheck(Thing) then
            toggleTouch(true)
        elseif Thing.Name == "RopeStart" then
            toggleTouch(true)
        end
    end)
    walljumpfix2 = LP.Character.HumanoidRootPart.TouchEnded:Connect(function(Thing)
        if badCheck(Thing) then
            toggleTouch(false)
        elseif Thing.Name == "RopeStart" then
            toggleTouch(false)
        end
    end)
    local function activateAnimation(CurrentAnimation)
        if CurrentAnimation and CurrentAnimation[1] and CurrentAnimation[2] and LP.Character and LP.Character.Humanoid then
            PlayAnim(CurrentAnimation[1],CurrentAnimation[2], LP.Character.Humanoid)
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
        end
    end)
    local RootPart = LP.Character.HumanoidRootPart
    local TimeStart = tick()
    Loop = RS.Heartbeat:Connect(function(DeltaTime)
        local NewFrame = #TAS
        local Divider = OldFrame + 60
        if Divider < #TAS then
            NewFrame = Divider
        end
       for i = OldFrame, NewFrame do
            local CurrentInfo = TAS[i]
            if (tick() - TimeStart) < CurrentInfo.time then
                break
            elseif i >= #TAS then
                Death:Disconnect()
                Loop:Disconnect()
                walljumpfix:Disconnect()
                walljumpfix2:Disconnect()
                toggleTouch(true)
                ViewingTAS = false
            elseif (tick() - TimeStart) >= CurrentInfo.time then
                OldFrame = i
                local CCFrame = CurrentInfo.CCFrame
                local CCameraCFrame = CurrentInfo.CCameraCFrame
                RootPart.CFrame = NewC(CCFrame[1], CCFrame[2], CCFrame[3]) * AngC(CCFrame[4], CCFrame[5], CCFrame[6]) + Offset
                CurrentCamera.CFrame = NewC(CCameraCFrame[1], CCameraCFrame[2], CCameraCFrame[3]) * AngC(CCameraCFrame[4], CCameraCFrame[5], CCameraCFrame[6]) + Offset
                activateAnimation(CurrentInfo.AAnimation)
            end
        end
    end)
end
local function SaveRun()
    local AllPlayerInfo = {}
    for i = 1, #Savestates do
        for j = 1, #Savestates[i] do
            local InfoFromSavestates = Savestates[i][j]
            local InfoAddingToAllPlayerInfo = {}
            InfoAddingToAllPlayerInfo.AAnimationChanged = InfoFromSavestates.Animation[2]
            InfoAddingToAllPlayerInfo.VVelocity = {InfoFromSavestates.Velocity.X, InfoFromSavestates.Velocity.Y, InfoFromSavestates.Velocity.Z}
            InfoAddingToAllPlayerInfo.CCameraCFrame = {InfoFromSavestates.CameraCFrame.X, InfoFromSavestates.CameraCFrame.Y, InfoFromSavestates.CameraCFrame.Z, InfoFromSavestates.CameraCFrame:ToEulerAnglesXYZ()}
            InfoAddingToAllPlayerInfo.CCFrame = {InfoFromSavestates.CFrame.X, InfoFromSavestates.CFrame.Y, InfoFromSavestates.CFrame.Z, InfoFromSavestates.CFrame:ToEulerAnglesXYZ()}
            if InfoFromSavestates.Animation and InfoFromSavestates.Animation[1] then
                InfoAddingToAllPlayerInfo.AAnimation = {InfoFromSavestates.Animation[1], InfoFromSavestates.Animation[2]}
            else
                InfoAddingToAllPlayerInfo.AAnimation = {"walk", 0.1}
            end
            InfoAddingToAllPlayerInfo.time = InfoFromSavestates.Time
            table.insert(AllPlayerInfo, InfoAddingToAllPlayerInfo)
        end
    end
    -- TAS file minifier 
    -- Starting from this line to ending line code was made by ian
    local function round(x)
        local factorOfTen = 10^(3)
        return math.floor(x * factorOfTen + .5) / factorOfTen
    end
    local function minfile(file)
        local tasFile = file
        local minTasFile = {}
        for t,data in ipairs(tasFile) do
            local minData = {}
            for key,val in pairs(data) do
                local minVal = nil
                if type(val) == "table" then
                    minVal = {}
                    for f,x in ipairs(val) do
                        if type(x) == "number" then table.insert(minVal, round(x))
                        else table.insert(minVal, x) end    
                    end
                else
                    minVal = round(val)
                end
                minData[key] = minVal
            end
            table.insert(minTasFile, minData)
        end
        return minTasFile
    end
    -- ending line
    local mapName = workspace.Map.Settings:GetAttribute("MapName")
    local AllPlayerInfo = minfile(AllPlayerInfo)
    writefile("Liquid_Mix/Records/"..custom_map_name..".json", game:GetService("HttpService"):JSONEncode(AllPlayerInfo))
    Alert("Saved", Color3.fromRGB(0, 255, 0), 1)
end

ReplicatedStorage.Remote.StartClientMapTimer.OnClientEvent:Wait()
task.wait(1)
SetUpMap()

if not isfolder("TAS") then
    makefolder("TAS")
end

local timer = tick()
local RecordLoop
local KeybindsConnect
local Death
local function ResetToNormal()
    AnimationHookConnection:Disconnect()
    hookAnimation = function()end
    RecordLoop:Disconnect()
    KeybindsConnect:Disconnect()
    Death:Disconnect()
    Map:Destroy()
    RealHUD.Parent = OldParent
    HUD:Destroy()
    LocalPlayer.Character.Humanoid.Health = 0
    print("Reset to normal"..RunID)
end
RecordLoop = RunService.Heartbeat:Connect(function(deltaTime)
    if not Pause then
        SetTimeGui()
        table.insert(PlayerInfo, ReturnPlayerInfo())
        if tick() - timer >= 2 then
        	-- AddSavestate()
        	timer = tick()
        end
    else
        timer = tick()
    end
    UpdSavestatesGUI()
    UpdFramesGUI()
end)

SaveRun()
KeybindsConnect = UserInputService.InputBegan:Connect(function(Key, Typing)
    if not Typing then
        Key = Key.KeyCode.Name
        if Key == Keybinds.UserPause then
            UserPause()
        elseif Key == Keybinds.AddSavestate then
            AddSavestate()
        elseif Key == Keybinds.RemoveSavestate then
            RemoveSavestate()
        elseif Key == Keybinds.BackSavestate then
            BackSavestate()
        elseif Key == Keybinds.CollisionToggler then
            CollisionToggler()
        elseif Key == Keybinds.SaveRun then
            SaveRun()
        elseif Key == Keybinds.GoFrameForward then
            FrameForwardStart()
        elseif Key == Keybinds.GoFrameBack then
            FrameBackStart()
        elseif Key == Keybinds.ResetToNormal then
            ResetToNormal()
        elseif Key == Keybinds.ViewTAS then
            if not ViewingTAS then
                AddSavestate()
                local TAS = {}
                for i = 1, #Savestates do
                    for j = 1, #Savestates[i] do
                        local InfoFromSavestates = Savestates[i][j]
                        local InfoAddingToAllPlayerInfo = {}
                        InfoAddingToAllPlayerInfo.AAnimationChanged = InfoFromSavestates.Animation[2]
                        InfoAddingToAllPlayerInfo.VVelocity = {InfoFromSavestates.Velocity.X, InfoFromSavestates.Velocity.Y, InfoFromSavestates.Velocity.Z}
                        InfoAddingToAllPlayerInfo.CCameraCFrame = {InfoFromSavestates.CameraCFrame.X, InfoFromSavestates.CameraCFrame.Y, InfoFromSavestates.CameraCFrame.Z, InfoFromSavestates.CameraCFrame:ToEulerAnglesXYZ()}
                        InfoAddingToAllPlayerInfo.CCFrame = {InfoFromSavestates.CFrame.X, InfoFromSavestates.CFrame.Y, InfoFromSavestates.CFrame.Z, InfoFromSavestates.CFrame:ToEulerAnglesXYZ()}
                        if InfoFromSavestates.Animation and InfoFromSavestates.Animation[1] then
                            InfoAddingToAllPlayerInfo.AAnimation = {InfoFromSavestates.Animation[1], InfoFromSavestates.Animation[2]}
                        else
                            InfoAddingToAllPlayerInfo.AAnimation = {"walk", 0.1}
                        end
                        InfoAddingToAllPlayerInfo.time = InfoFromSavestates.Time
                        table.insert(TAS, InfoAddingToAllPlayerInfo)
                    end
                end
                ViewTAS(TAS)
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(Key, Typing)
    if not Typing then
        Key = Key.KeyCode.Name
        if Key == Keybinds.GoFrameBack then
            isFrameBackHeld = false
        elseif Key == Keybinds.GoFrameForward then
            isFrameForwardHeld = false
        end
    end
end)

Death = LocalPlayer.Character.Humanoid.Died:Connect(function()
    task.wait(.1)
    if not Pause then
        UserPause()
    end
    LocalPlayer.CharacterAdded:wait()
    task.wait(.1)
    BackSavestate()
end)
