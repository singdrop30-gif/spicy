-- ==========================================
-- 🔥 HOK HUB | Steal An Egg Script v2.1
-- ✅ រត់ | លោត | ស៊ុត ESP | Auto Steal | កម្លាំង | ស្ថិតិ
-- ==========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI = {
    BG = Color3.fromRGB(18,12,25),
    Accent = Color3.fromRGB(255,0,127),
    Sec = Color3.fromRGB(35,30,45),
    Text = Color3.new(1,1,1),
    Green = Color3.fromRGB(45,200,80),
    Red = Color3.fromRGB(220,50,80),
    Yellow = Color3.fromRGB(255,200,0)
}

local State = {
    Speed = false, Jump = false, Ragdoll = false,
    EggESP = true, AutoSteal = false,
    BoostSpeed = 500, BoostStrength = 100,
    Distance = 25, EggCount = 0
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HokHub"
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,340,0,550)
Main.Position = UDim2.new(0.02,0,0.5,-275)
Main.BackgroundColor3 = UI.BG
Main.BorderSizePixel = 3
Main.BorderColor3 = UI.Accent
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

local Title = Instance.new("Frame")
Title.Size = UDim2.new(1,0,0,55)
Title.BackgroundColor3 = UI.Accent
Title.Parent = Main
Instance.new("UICorner",Title).CornerRadius = UDim.new(0,14)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1,0,1,0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🔥 មជ្ឈមណ្ឌល HOK — Steal An Egg"
TitleText.TextColor3 = UI.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.Parent = Title

local StatsBox = Instance.new("Frame")
StatsBox.Size = UDim2.new(0,300,0,85)
StatsBox.Position = UDim2.new(0,20,0,70)
StatsBox.BackgroundColor3 = UI.Sec
StatsBox.Parent = Main
Instance.new("UICorner",StatsBox).CornerRadius = UDim.new(0,8)

local StatsText = Instance.new("TextLabel")
StatsText.Size = UDim2.new(1,-10,1,0)
StatsText.Position = UDim2.new(0,10,0,0)
StatsText.BackgroundTransparency = 1
StatsText.Text = "🏃 ល្បឿន: 16\n💪 កម្លាំង: 1\n🥚 ស៊ុតក្នុងចម្ងាយ: 0\n📍 ចម្ងាយ: 25"
StatsText.TextColor3 = UI.Text
StatsText.Font = Enum.Font.Gotham
StatsText.TextSize = 12
StatsText.TextXAlignment = Enum.TextXAlignment.Left
StatsText.TextYAlignment = Enum.TextYAlignment.Top
StatsText.Parent = StatsBox

local function Label(Text,Y)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1,-20,0,28)
    L.Position = UDim2.new(0,10,0,Y)
    L.BackgroundTransparency = 1
    L.Text = Text
    L.TextColor3 = UI.Yellow
    L.Font = Enum.Font.GothamBold
    L.TextSize = 15
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = Main
end

local function Button(Name,Text,Y,Callback)
    local B = Instance.new("TextButton")
    B.Name = Name
    B.Size = UDim2.new(0,300,0,44)
    B.Position = UDim2.new(0,20,0,Y)
    B.BackgroundColor3 = UI.Red
    B.Text = Text
    B.TextColor3 = UI.Text
    B.Font = Enum.Font.GothamBold
    B.TextSize = 14
    B.Parent = Main
    Instance.new("UICorner",B).CornerRadius = UDim.new(0,8)
    B.MouseButton1Click:Connect(function()
        Callback()
        State[Name] = not State[Name]
        B.BackgroundColor3 = State[Name] and UI.Green or UI.Red
    end)
end

Label("🏃 ចលនា & ល្បឿន", 175)
Button("Speed", "⚡ បង្កើនល្បឿនរត់", 205, function() end)
Button("Jump", "🦘 លោតគ្មានដែនកំណត់", 255, function() end)

Label("💪 កម្លាំង", 310)
Button("Ragdoll", "💪 ការពារកុំឱ្យដួល", 340, function() end)

Label("🥚 ស៊ុត & Auto", 400)
Button("EggESP", "👁️ មើលឃើញស៊ុតទាំងអស់", 430, function() end)
Button("AutoSteal", "🥚 Auto រើសស៊ុត", 480, function() end)

UIS.JumpRequest:Connect(function()
    if State.Jump then
        task.wait()
        local Char = Player.Character
        if Char and Char:FindFirstChild("Humanoid") then
            Char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RS.Heartbeat:Connect(function()
    local Char = Player.Character
    if not Char or not Char:FindFirstChild("Humanoid") then return end
    local Hum = Char.Humanoid
    local Root = Char:FindFirstChild("HumanoidRootPart")
    if not Root then return end
    
    if State.Speed then
        Hum.WalkSpeed = State.BoostSpeed
    else
        Hum.WalkSpeed = 16
    end
    
    local EggCount = 0
    for _, v in pairs(WS:GetDescendants()) do
        if v:IsA("BasePart") and string.find(string.lower(v.Name), "egg") then
            if (v.Position - Root.Position).Magnitude < State.Distance then
                EggCount = EggCount + 1
            end
        end
    end
    
    StatsText.Text = string.format(
        "🏃 ល្បឿន: %d\n💪 កម្លាំង: %d\n🥚 ស៊ុតក្នុងចម្ងាយ: %d\n📍 ចម្ងាយ: %d",
        Hum.WalkSpeed, State.BoostStrength, EggCount, State.Distance
    )
end)

print("✅ 🔥 HOK HUB — បានផ្ទុកដោយជោគជ័យ!")
