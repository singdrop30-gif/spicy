local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")
local Character, Humanoid, RootPart

-- 🎨 ពណ៌
local UI = {
    BG = Color3.fromRGB(25, 20, 35),
    Accent = Color3.fromRGB(255, 0, 140),
    AccentBright = Color3.fromRGB(255, 60, 180),
    Green = Color3.fromRGB(40, 180, 40),
    Red = Color3.fromRGB(180, 40, 40),
    Gray = Color3.fromRGB(55, 45, 75),
    DarkGray = Color3.fromRGB(40, 30, 55),
    Text = Color3.new(1, 1, 1),
    Gold = Color3.fromRGB(255, 215, 0)
}

-- 📦 ស្ថានភាព
local State = {
    PanelOpen = false,
    AutoEnabled = false,
    CurrentSpeed = 100,
    IsMoving = false,
    NoKnockback = true,
    NoDamage = true,
    InstantHatch = false,
    NoCountdown = false
}

-- 🐾 សត្វ
local Creatures = {
    {Name = "Winged Lamb", Value = 1.3, Unit = "M/s", Color = Color3.fromRGB(255, 230, 150)},
    {Name = "Bladehide", Value = 753.7, Unit = "K/s", Color = Color3.fromRGB(80, 160, 220)},
    {Name = "Cosmic Gecko", Value = 720.8, Unit = "K/s", Color = Color3.fromRGB(100, 80, 220)},
    {Name = "Light Dove", Value = 557.3, Unit = "K/s", Color = Color3.fromRGB(240, 240, 255)},
    {Name = "Cosmic Gorilla", Value = 379.0, Unit = "K/s", Color = Color3.fromRGB(70, 90, 140)},
    {Name = "Pure Jellyfish", Value = 950.0, Unit = "K/s", Color = Color3.fromRGB(200, 100, 255)}
}

-- 🛡️ ការពារ — គេវ៉ៃអត់ដួល + អត់ខូចខាត
local function SetupProtection()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    
    Humanoid.MaxHealth = math.huge
    Humanoid.Health = math.huge
    RootPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0)
    
    Humanoid.HealthChanged:Connect(function(newHealth)
        if State.NoDamage and newHealth < Humanoid.MaxHealth then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end)
    
    RunService.Stepped:Connect(function()
        if State.NoKnockback and RootPart then
            RootPart.Velocity = Vector3.new(RootPart.Velocity.X * 0.1, RootPart.Velocity.Y, RootPart.Velocity.Z * 0.1)
        end
    end)
end

Player.CharacterAdded:Connect(SetupProtection)
SetupProtection()

-- 🥚 បើកពងភ្លាមៗ + បិទម៉ោងរាប់ថយ
local function SetupEggHatch()
    RunService.Stepped:Connect(function()
        if State.NoCountdown then
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("NumberValue") and string.find(string.lower(v.Name), "countdown") 
                or string.find(string.lower(v.Name), "timer") then
                    v.Value = 0
                end
            end
        end
        if State.InstantHatch then
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("BasePart") and string.find(string.lower(v.Name), "egg") then
                    for _, child in pairs(v:GetChildren()) do
                        if child:IsA("NumberValue") or child:IsA("IntValue") then
                            if string.find(string.lower(child.Name), "time") 
                            or string.find(string.lower(child.Name), "hatch")
                            or string.find(string.lower(child.Name), "timer") then
                                child.Value = 0
                            end
                        end
                    end
                end
            end
        end
    end)
end
SetupEggHatch()

-- 🚀 ទៅយកសត្វ
local function FlyTo(Target)
    if not Target or State.IsMoving then return end
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    State.IsMoving = true
    local Root = Player.Character.HumanoidRootPart
    local EndPos = Target.Position + Vector3.new(0, 3, 0)
    local Dist = (EndPos - Root.Position).Magnitude
    local Dur = math.max(0.15, Dist / State.CurrentSpeed)
    
    Tween:Create(Root, TweenInfo.new(Dur), {CFrame = CFrame.new(EndPos)}):Play()
    task.wait(Dur)
    State.IsMoving = false
end

-- 🖥️ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JinghokHub"
ScreenGui.Parent = Gui

-- ==========================================
-- 🖼️ LOGO BUTTON
-- ==========================================
local LogoBtn = Instance.new("Frame")
LogoBtn.Size = UDim2.new(0, 140, 0, 140)
LogoBtn.Position = UDim2.new(0.5, -70, 0.6, -70)
LogoBtn.BackgroundTransparency = 1
LogoBtn.Active = true
LogoBtn.Draggable = true
LogoBtn.Parent = ScreenGui

local LogoHex = Instance.new("Frame")
LogoHex.Size = UDim2.new(1, 0, 1, 0)
LogoHex.BackgroundTransparency = 1
LogoHex.BorderSizePixel = 4
LogoHex.BorderColor3 = UI.Accent
LogoHex.Parent = LogoBtn
Instance.new("UICorner", LogoHex).CornerRadius = UDim.new(0, 14)

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0.5, 0)
LogoText.Position = UDim2.new(0, 0, 0.25, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "Jinghok"
LogoText.TextColor3 = UI.AccentBright
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 32
LogoText.TextScaled = true
LogoText.TextStrokeTransparency = 0
LogoText.TextStrokeColor3 = UI.Accent
LogoText.Parent = LogoBtn

local HornL = Instance.new("TextLabel")
HornL.Size = UDim2.new(0, 35, 0, 50)
HornL.Position = UDim2.new(0.02, 0, -0.05, 0)
HornL.BackgroundTransparency = 1
HornL.Text = "◢"
HornL.TextColor3 = UI.Accent
HornL.Font = Enum.Font.GothamBold
HornL.TextSize = 40
HornL.Rotation = -30
HornL.Parent = LogoBtn

local HornR = Instance.new("TextLabel")
HornR.Size = UDim2.new(0, 35, 0, 50)
HornR.Position = UDim2.new(0.68, 0, -0.05, 0)
HornR.BackgroundTransparency = 1
HornR.Text = "◣"
HornR.TextColor3 = UI.Accent
HornR.Font = Enum.Font.GothamBold
HornR.TextSize = 40
HornR.Rotation = 30
HornR.Parent = LogoBtn

local ClickArea = Instance.new("TextButton")
ClickArea.Size = UDim2.new(1, 0, 1, 0)
ClickArea.BackgroundTransparency = 1
ClickArea.Text = ""
ClickArea.Parent = LogoBtn

-- ==========================================
-- 📋 MAIN PANEL
-- ==========================================
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 440, 0, 620)
Panel.Position = UDim2.new(0.5, -220, 0.5, -310)
Panel.BackgroundColor3 = UI.BG
Panel.BorderSizePixel = 3
Panel.BorderColor3 = UI.Accent
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = ScreenGui
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 14)

-- ក្បាល
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = UI.Accent
Header.Parent = Panel
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, 0, 1, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "💖 JINGHOK HUB"
HeaderTitle.TextColor3 = UI.Text
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 22
HeaderTitle.Parent = Header

-- 🥚 បើកពងភ្លាមៗ
local InstantHatchBtn = Instance.new("TextButton")
InstantHatchBtn.Size = UDim2.new(0.90, 0, 0, 45)
InstantHatchBtn.Position = UDim2.new(0.05, 0, 0.10, 0)
InstantHatchBtn.BackgroundColor3 = UI.Gray
InstantHatchBtn.Text = "🥚 បើកពងភ្លាមៗ៖ បិទ"
InstantHatchBtn.TextColor3 = UI.Text
InstantHatchBtn.Font = Enum.Font.GothamBold
InstantHatchBtn.TextSize = 14
InstantHatchBtn.Parent = Panel
Instance.new("UICorner", InstantHatchBtn).CornerRadius = UDim.new(0, 10)

-- ⏱️ បិទម៉ោងរាប់ថយ
local NoCountdownBtn = Instance.new("TextButton")
NoCountdownBtn.Size = UDim2.new(0.90, 0, 0, 45)
NoCountdownBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
NoCountdownBtn.BackgroundColor3 = UI.Gray
NoCountdownBtn.Text = "⏱️ បិទម៉ោងរាប់ថយ៖ បិទ"
NoCountdownBtn.TextColor3 = UI.Text
NoCountdownBtn.Font = Enum.Font.GothamBold
NoCountdownBtn.TextSize = 14
NoCountdownBtn.Parent = Panel
Instance.new("UICorner", NoCountdownBtn).CornerRadius = UDim.new(0, 10)

-- 🛡️ គេវ៉ៃអត់ដួល
local ProtectBtn = Instance.new("TextButton")
ProtectBtn.Size = UDim2.new(0.90, 0, 0, 45)
ProtectBtn.Position = UDim2.new(0.05, 0, 0.26, 0)
ProtectBtn.BackgroundColor3 = UI.Green
ProtectBtn.Text = "🛡️ គេវ៉ៃអត់ដួល៖ បើក"
ProtectBtn.TextColor3 = UI.Text
ProtectBtn.Font = Enum.Font.GothamBold
ProtectBtn.TextSize = 14
ProtectBtn.Parent = Panel
Instance.new("UICorner", ProtectBtn).CornerRadius = UDim.new(0, 10)

-- ⚡ ល្បឿនរត់
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.90, 0, 0, 35)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "⚡ ល្បឿនរត់"
SpeedLabel.TextColor3 = UI.AccentBright
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 15
SpeedLabel.Parent = Panel

local SpeedContainer = Instance.new("Frame")
SpeedContainer.Size = UDim2.new(0.90, 0, 0, 45)
SpeedContainer.Position = UDim2.new(0.05, 0, 0.40, 0)
SpeedContainer.BackgroundTransparency = 1
SpeedContainer.Parent = Panel

local SpeedBtns = {}
local Speeds = {50, 100, 500, 1000, 2000}
for i, speed in ipairs(Speeds) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.18, -4, 1, 0)
    Btn.Position = UDim2.new((i-1)*0.20, 0, 0, 0)
    Btn.BackgroundColor3 = speed == State.CurrentSpeed and UI.Green or UI.Gray
    Btn.Text = tostring(speed)
    Btn.TextColor3 = UI.Text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = SpeedContainer
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    SpeedBtns[speed] = Btn
    
    Btn.MouseButton1Click:Connect(function()
        State.CurrentSpeed = speed
        for s, b in pairs(SpeedBtns) do
            b.BackgroundColor3 = s == speed and UI.Green or UI.Gray
        end
    end)
end

-- 🥚 យកពងដោយស្វ័យប្រវត្តិ
local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0.90, 0, 0, 45)
AutoBtn.Position = UDim2.new(0.05, 0, 0.49, 0)
AutoBtn.BackgroundColor3 = UI.Gray
AutoBtn.Text = "🥚 យកពងដោយស្វ័យប្រវត្តិ៖ បិទ"
AutoBtn.TextColor3 = UI.Text
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.TextSize = 14
AutoBtn.Parent = Panel
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 10)

-- 🐾 បញ្ជីសត្វ
local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(0.90, 0, 0.42, 0)
List.Position = UDim2.new(0.05, 0, 0.56, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 6
List.ScrollBarColor3 = UI.Accent
List.Parent = Panel

local function RefreshList()
    List:ClearAllChildren()
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = List
    
    for _, C in ipairs(Creatures) do
        local Item = Instance.new("Frame")
        Item.Size = UDim2.new(1, 0, 0, 55)
        Item.BackgroundColor3 = UI.Gray
        Item.Parent = List
        Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 10)
        
        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(0.50, 0, 1, 0)
        Name.Position = UDim2.new(0.03, 0, 0, 0)
        Name.BackgroundTransparency = 1
        Name.Text = C.Name
        Name.TextColor3 = C.Color
        Name.Font = Enum.Font.GothamBold
        Name.TextSize = 12
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.Parent = Item
        
        local Value = Instance.new("TextLabel")
        Value.Size = UDim2.new(0.22, 0, 1, 0)
        Value.Position = UDim2.new(0.53, 0, 0, 0)
        Value.BackgroundTransparency = 1
        Value.Text = "$" .. C.Value .. C.Unit
        Value.TextColor3 = UI.Gold
        Value.Font = Enum.Font.Gotham
        Value.TextSize = 11
        Value.Parent = Item
        
        local Go = Instance.new("TextButton")
        Go.Size = UDim2.new(0.20, 0, 0, 45)
        Go.Position = UDim2.new(0.75, 0, 0.09, 0)
        Go.BackgroundColor3 = UI.Green
        Go.Text = "✅ យក"
        Go.TextColor3 = UI.Text
        Go.Font = Enum.Font.GothamBold
        Go.TextSize = 12
        Go.Parent = Item
        Instance.new("UICorner", Go).CornerRadius = UDim.new(0, 8)
        
        Go.MouseButton1Click:Connect(function()
            local Found = nil
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("BasePart") and string.find(string.lower(v.Name), string.lower(C.Name)) then
                    Found = v; break
                end
            end
            if Found then
                FlyTo(Found)
                Go.Text = "✅ បានហើយ!"
                task.delay(1.5, function() Go.Text = "✅ យក" end)
            else
                Go.Text = "❌ រកមិនឃើញ"
                task.delay(1.5, function() Go.Text = "✅ យក" end)
            end
        end)
    end
end

-- 🖱️ បើក/បិទផ្ទាំង
ClickArea.MouseButton1Click:Connect(function()
    State.PanelOpen = not State.PanelOpen
    Panel.Visible = State.PanelOpen
    if State.PanelOpen then RefreshList() end
end)

-- 🥚 បើកពងភ្លាមៗ
InstantHatchBtn.MouseButton1Click:Connect(function()
    State.InstantHatch = not State.InstantHatch
    InstantHatchBtn.BackgroundColor3 = State.InstantHatch and UI.Green or UI.Gray
    InstantHatchBtn.Text = State.InstantHatch and "🥚 បើកពងភ្លាមៗ៖ បើក" or "🥚 បើកពងភ្លាមៗ៖ បិទ"
end)

-- ⏱️ បិទម៉ោងរាប់ថយ
NoCountdownBtn.MouseButton1Click:Connect(function()
    State.NoCountdown = not State.NoCountdown
    NoCountdownBtn.BackgroundColor3 = State.NoCountdown and UI.Green or UI.Gray
    NoCountdownBtn.Text = State.NoCountdown and "⏱️ បិទម៉ោងរាប់ថយ៖ បើក" or "⏱️ បិទម៉ោងរាប់ថយ៖ បិទ"
end)

-- 🛡️ គេវ៉ៃអត់ដួល
ProtectBtn.MouseButton1Click:Connect(function()
    State.NoKnockback = not State.NoKnockback
    State.NoDamage = State.NoKnockback
    ProtectBtn.BackgroundColor3 = State.NoKnockback and UI.Green or UI.Gray
    ProtectBtn.Text = State.NoKnockback and "🛡️ គេវ៉ៃអត់ដួល៖ បើក" or "🛡️ គេវ៉ៃអត់ដួល៖ បិទ"
end)

-- 🥚 យកពងដោយស្វ័យប្រវត្តិ
AutoBtn.MouseButton1Click:Connect(function()
    State.AutoEnabled = not State.AutoEnabled
    AutoBtn.BackgroundColor3 = State.AutoEnabled and UI.Green or UI.Gray
    AutoBtn.Text = State.AutoEnabled and "🥚 យកពងដោយស្វ័យប្រវត្តិ៖ បើក" or "🥚 យកពងដោយស្វ័យប្រវត្តិ៖ បិទ"
end)

print("💖 JINGHOK HUB — រួចរាល់!")
print("💖 ចុច Logo Jinghok ដើម្បីបើក!")
print("🥚 អក្សរទាំងអស់ជាភាសាខ្មែរ!")
