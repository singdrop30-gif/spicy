-- HOK HUB - Steal An Egg
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

local State = {Speed=false, Jump=false, EggESP=true, AutoSteal=false}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HokHub"
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,320,0,480)
Main.Position = UDim2.new(0.02,0,0.5,-240)
Main.BackgroundColor3 = UI.BG
Main.BorderSizePixel = 3
Main.BorderColor3 = UI.Accent
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Title = Instance.new("Frame")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundColor3 = UI.Accent
Title.Parent = Main
Instance.new("UICorner",Title).CornerRadius = UDim.new(0,12)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1,0,1,0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🔥 មជ្ឈមណ្ឌល HOK"
TitleText.TextColor3 = UI.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.Parent = Title

local StatsBox = Instance.new("Frame")
StatsBox.Size = UDim2.new(0,280,0,70)
StatsBox.Position = UDim2.new(0,20,0,65)
StatsBox.BackgroundColor3 = UI.Sec
StatsBox.Parent = Main
Instance.new("UICorner",StatsBox).CornerRadius = UDim.new(0,8)

local StatsText = Instance.new("TextLabel")
StatsText.Size = UDim2.new(1,-10,1,0)
StatsText.Position = UDim2.new(0,10,0,0)
StatsText.BackgroundTransparency = 1
StatsText.Text = "🏃 ល្បឿន: 16\n🥚 ស៊ុតក្បែរ: 0"
StatsText.TextColor3 = UI.Text
StatsText.Font = Enum.Font.Gotham
StatsText.TextSize = 12
StatsText.TextXAlignment = Enum.TextXAlignment.Left
StatsText.Parent = StatsBox

local function Label(Text,Y)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1,-20,0,25)
    L.Position = UDim2.new(0,10,0,Y)
    L.BackgroundTransparency = 1
    L.Text = Text
    L.TextColor3 = UI.Yellow
    L.Font = Enum.Font.GothamBold
    L.TextSize = 14
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = Main
end

local function Button(Name,Text,Y,Callback)
    local B = Instance.new("TextButton")
    B.Name = Name
    B.Size = UDim2.new(0,280,0,42)
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

Label("🏃 ចលនា", 150)
Button("Speed", "⚡ រត់លឿន", 180, function() end)
Button("Jump", "🦘 លោតគ្មានដែនកំណត់", 232, function() end)

Label("🥚 ស៊ុត", 290)
Button("EggESP", "👁️ មើលស៊ុតទាំងអស់", 320, function() end)
Button("AutoSteal", "🥚 Auto រើសស៊ុត", 372, function() end)

UIS.JumpRequest:Connect(function()
    if State.Jump then task.wait()
        local C = Player.Character
        if C and C:FindFirstChild("Humanoid") then
            C.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RS.Heartbeat:Connect(function()
    local C = Player.Character
    if not C or not C:FindFirstChild("Humanoid") then return end
    local H = C.Humanoid
    local R = C:FindFirstChild("HumanoidRootPart")
    if not R then return end
    
    if State.Speed then H.WalkSpeed = 500 else H.WalkSpeed = 16 end
    
    local cnt = 0
    for _,v in pairs(WS:GetDescendants()) do
        if v:IsA("BasePart") and string.find(string.lower(v.Name),"egg") then
            if (v.Position - R.Position).Magnitude < 30 then cnt = cnt + 1 end
        end
    end
    StatsText.Text = "🏃 ល្បឿន: "..H.WalkSpeed.."\n🥚 ស៊ុតក្បែរ: "..cnt
end)

print("✅ HOK HUB បានផ្ទុក!")
