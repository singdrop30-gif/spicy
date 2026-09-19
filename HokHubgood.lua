-- ==========================================
-- 💖 JINGHOK HUB | Steal An Egg
-- ✅ ចម្លងពី Chilli Hub → ប្តូរឈ្មោះ + អក្សរខ្មែរ
-- ==========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- UI Colors
local UI = {
    MainBG = Color3.fromRGB(30, 30, 45),
    Accent = Color3.fromRGB(255, 0, 140),
    Green = Color3.fromRGB(40, 180, 40),
    Red = Color3.fromRGB(180, 0, 0),
    Gray = Color3.fromRGB(60, 60, 80),
    Text = Color3.new(1, 1, 1)
}

-- State
local State = {
    AutoSteal = false,
    SortByValue = true,
    TweenSpeed = 1000,
    ESP_Enabled = true,
    IsMoving = false,
    Target = nil
}

-- Creature Data
local Creatures = {
    {Name = "Winged Lamb", Value = 1.3, Unit = "M/s", Rarity = "Common", Color = Color3.fromRGB(255, 230, 150)},
    {Name = "Bladehide", Value = 753.7, Unit = "K/s", Rarity = "Rare", Color = Color3.fromRGB(80, 160, 220)},
    {Name = "Cosmic Gecko", Value = 720.8, Unit = "K/s", Rarity = "Rare", Color = Color3.fromRGB(100, 80, 220)},
    {Name = "Light Dove", Value = 557.3, Unit = "K/s", Rarity = "Common", Color = Color3.fromRGB(240, 240, 255)},
    {Name = "Cosmic Gorilla", Value = 379.0, Unit = "K/s", Rarity = "Rare", Color = Color3.fromRGB(70, 90, 140)},
    {Name = "Pure Jellyfish", Value = 950.0, Unit = "K/s", Rarity = "Legendary", Color = Color3.fromRGB(200, 100, 255)}
}

-- Screen Gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JinghokHub"
ScreenGui.Parent = PlayerGui

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.015, 0, 0.5, -28)
ToggleBtn.BackgroundColor3 = UI.Accent
ToggleBtn.Text = "💖"
ToggleBtn.TextColor3 = UI.Text
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 24
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 12)

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Name = "StealPanel"
Panel.Size = UDim2.new(0, 420, 0, 520)
Panel.Position = UDim2.new(0.07, 0, 0.5, -260)
Panel.BackgroundColor3 = UI.MainBG
Panel.BorderSizePixel = 3
Panel.BorderColor3 = UI.Red
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = ScreenGui
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = UI.Red
Header.Parent = Panel
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.55, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💖 Jinghok Hub"
Title.TextColor3 = UI.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Header

-- Sort Button
local SortBtn = Instance.new("TextButton")
SortBtn.Size = UDim2.new(0.35, -10, 0, 35)
SortBtn.Position = UDim2.new(0.62, 0, 0.01, 0)
SortBtn.BackgroundColor3 = UI.Green
SortBtn.Text = "Sort: Value"
SortBtn.TextColor3 = UI.Text
SortBtn.Font = Enum.Font.GothamBold
SortBtn.TextSize = 14
SortBtn.Parent = Header
Instance.new("UICorner", SortBtn).CornerRadius = UDim.new(0, 8)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(0.94, 0, 0, 50)
TopBar.Position = UDim2.new(0.03, 0, 0.11, 0)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Panel

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0.46, 0, 1, 0)
AutoBtn.BackgroundColor3 = UI.Green
AutoBtn.Text = "Auto Steal: ON"
AutoBtn.TextColor3 = UI.Text
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.TextSize = 14
AutoBtn.Parent = TopBar
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.46, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0.51, 0, 0, 0)
SpeedLabel.BackgroundColor3 = UI.Gray
SpeedLabel.Text = "កម្លាំងរត់: 1000"
SpeedLabel.TextColor3 = UI.Text
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 14
SpeedLabel.Parent = TopBar
Instance.new("UICorner", SpeedLabel).CornerRadius = UDim.new(0, 8)

-- Speed Slider
local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(0.94, 0, 0, 40)
SliderFrame.Position = UDim2.new(0.03, 0, 0.22, 0)
SliderFrame.BackgroundTransparency = 1
SliderFrame.Parent = Panel

local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(1, 0, 0, 12)
SliderBg.Position = UDim2.new(0, 0, 0.5, -6)
SliderBg.BackgroundColor3 = UI.Gray
SliderBg.Parent = SliderFrame
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 6)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(1, 0, 0, 12)
SliderFill.BackgroundColor3 = UI.Accent
SliderFill.Parent = SliderBg
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 6)

-- Creature List
local ListContainer = Instance.new("ScrollingFrame")
ListContainer.Size = UDim2.new(0.94, 0, 0.60, 0)
ListContainer.Position = UDim2.new(0.03, 0, 0.34, 0)
ListContainer.BackgroundTransparency = 1
ListContainer.ScrollBarThickness = 6
ListContainer.ScrollBarColor3 = UI.Gray
ListContainer.Parent = Panel

-- Functions
local function FlyToTarget(TargetPart)
    if not TargetPart or State.IsMoving then return end
    local Char = Player.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    
    State.IsMoving = true
    State.Target = TargetPart
    
    local Root = Char.HumanoidRootPart
    local StartPos = Root.Position
    local EndPos = TargetPart.Position + Vector3.new(0, 3, 0)
    local Distance = (EndPos - StartPos).Magnitude
    local Duration = math.max(0.15, Distance / State.TweenSpeed)
    
    local TweenInfo = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local Goal = {CFrame = CFrame.new(EndPos)}
    local TweenObj = TweenService:Create(Root, TweenInfo, Goal)
    TweenObj:Play()
    
    TweenObj.Completed:Connect(function()
        State.IsMoving = false
        State.Target = nil
    end)
end

local function RefreshList()
    ListContainer:ClearAllChildren()
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = ListContainer
    
    local Sorted = {}
    for _, c in ipairs(Creatures) do table.insert(Sorted, c) end
    if State.SortByValue then
        table.sort(Sorted, function(a, b) return a.Value > b.Value end)
    end
    
    for i, Creature in ipairs(Sorted) do
        local Item = Instance.new("Frame")
        Item.Size = UDim2.new(1, 0, 0, 55)
        Item.BackgroundColor3 = UI.Gray
        Item.Parent = ListContainer
        Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 8)
        
        local NameLbl = Instance.new("TextLabel")
        NameLbl.Size = UDim2.new(0.45, 0, 0, 28)
        NameLbl.Position = UDim2.new(0.03, 0, 0, 2)
        NameLbl.BackgroundTransparency = 1
        NameLbl.Text = Creature.Name
        NameLbl.TextColor3 = Creature.Color
        NameLbl.Font = Enum.Font.GothamBold
        NameLbl.TextSize = 13
        NameLbl.TextXAlignment = Enum.TextXAlignment.Left
        NameLbl.Parent = Item
        
        local ValueLbl = Instance.new("TextLabel")
        ValueLbl.Size = UDim2.new(0.20, 0, 0, 22)
        ValueLbl.Position = UDim2.new(0.03, 0, 0.52, 0)
        ValueLbl.BackgroundTransparency = 1
        ValueLbl.Text = "$" .. Creature.Value .. Creature.Unit
        ValueLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
        ValueLbl.Font = Enum.Font.Gotham
        ValueLbl.TextSize = 11
        ValueLbl.TextXAlignment = Enum.TextXAlignment.Left
        ValueLbl.Parent = Item
        
        local StealBtn = Instance.new("TextButton")
        StealBtn.Size = UDim2.new(0.25, 0, 0, 40)
        StealBtn.Position = UDim2.new(0.72, 0, 0.13, 0)
        StealBtn.BackgroundColor3 = UI.Green
        StealBtn.Text = "Steal"
        StealBtn.TextColor3 = UI.Text
        StealBtn.Font = Enum.Font.GothamBold
        StealBtn.TextSize = 13
        StealBtn.Parent = Item
        Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 8)
        
        StealBtn.MouseButton1Click:Connect(function()
            local Found = nil
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("BasePart") and string.find(string.lower(v.Name), string.lower(Creature.Name)) then
                    Found = v
                    break
                end
            end
            if Found then
                FlyToTarget(Found)
                StealBtn.Text = "Going!"
                task.delay(1.5, function() StealBtn.Text = "Steal" end)
            else
                StealBtn.Text = "Not Found"
                task.delay(1.5, function() StealBtn.Text = "Steal" end)
            end
        end)
    end
end

-- Toggle Panel
ToggleBtn.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
    if Panel.Visible then RefreshList() end
end)

-- Auto Steal Toggle
AutoBtn.MouseButton1Click:Connect(function()
    State.AutoSteal = not State.AutoSteal
    AutoBtn.BackgroundColor3 = State.AutoSteal and UI.Green or UI.Gray
    AutoBtn.Text = State.AutoSteal and "Auto Steal: ON" or "Auto Steal: OFF"
end)

-- Sort Toggle
SortBtn.MouseButton1Click:Connect(function()
    State.SortByValue = not State.SortByValue
    SortBtn.Text = State.SortByValue and "Sort: Value" or "Sort: Rarity"
    RefreshList()
end)

-- Speed Slider
SliderBg.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        local Pos = math.clamp((UIS:GetMouseLocation().X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        State.TweenSpeed = Pos < 0.33 and 100 or Pos < 0.66 and 500 or 1000
        SpeedLabel.Text = "កម្លាំងរត់: " .. State.TweenSpeed
        SliderFill.Size = UDim2.new(Pos, 0, 1, 0)
    end
end)

print("💖 Jinghok Hub — Loaded Successfully!")
print("💖 Click the 💖 button to open the panel")
