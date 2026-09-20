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
    AccentBright = 255, 60, 180),
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
-- 🖼️ LOGO 45x45 | អូសបានគ្រប់ទីកន្លែង
-- ==========================================
local LogoBtn = Instance.new("TextButton")
LogoBtn.Name = "JinghokLogo"
LogoBtn.Size = UDim2.new(0, 45, 0, 45)
LogoBtn.Position = UDim2.new(0.02, 0, 0.88, 0)
LogoBtn.BackgroundTransparency = 1
LogoBtn.Text = "🦋"
LogoBtn.Font = Enum.Font.GothamBold
LogoBtn.TextSize = 28
LogoBtn.Active = true
LogoBtn.Draggable = true
LogoBtn.AutoLocalize = false
LogoBtn.Parent = ScreenGui

-- ==========================================
-- 📋 MAIN PANEL
-- ==========================================
local Panel = Instance.new("Frame")
Panel.Name = "MainPanel"
Panel.Size = UDim2.new(0, 420, 0, 580)
Panel.Position = UDim2.new(0.5, -210, 0.5, -290)
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
InstantHatchBtn.Text = "🥚 45x45 បើកពងភ្លាមៗ៖ បិទ"
<[SILENT_never_used_51bce0c785ca2f68081bfa7d91973934]>
ខ្ញុំនឹងជួសជុលកូដដែលនៅខូចនេះឱ្យវាដំណើរការត្រឹមត្រូវវិញ! 😊

```lua
-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ Logo 45x45 | អូសបានគ្រប់ទីកន្លែង | ប៊ូតុង Function
-- ==========================================

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
    {Name = "<[SILENT_never_used_51bce0c785ca2f68081bfa7d91973934]>
ខ្ញុំនឹងបន្ថែមកូដឱ្យវាចុចហើយមាន Panel Function ឡើងមក! 😊

```lua
-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ Logo 45x45 | អូសបានគ្រប់ទីកន្លែង | ប៊ូតុង Function
-- ==========================================

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
-- 🖼️ LOGO 45x45 | អូសបានគ្រប់ទីកន្លែង
-- ==========================================
local LogoBtn = Instance.new("TextButton")
LogoBtn.Name = "JinghokLogo"
LogoBtn.Size = UDim2.new(0, 45, 0, 45)
LogoBtn.Position = UDim2.new(0.02, 0, 0.88, 0)
LogoBtn.BackgroundTransparency = 1
LogoBtn.Text = "🦋"
LogoBtn.Font = Enum.Font.GothamBold
LogoBtn.TextSize = 28
LogoBtn.Active = true
LogoBtn.Draggable = true
LogoBtn.AutoLocalize = false
LogoBtn.Parent = ScreenGui

-- ==========================================
-- 📋 MAIN PANEL
-- ==========================================
local Panel = Instance.new("Frame")
Panel.Name = "MainPanel"
Panel.Size = UDim2.new(0, 420, 0, 580)
Panel.Position = UDim2.new(0.5, -210, 0.5, -290)
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

-- 📜 Function List
local FunctionList = Instance.new("ScrollingFrame")
FunctionList.Size = UDim2.new(0.90, 0, 0, 200)
FunctionList.Position = UDim2.new(0.05, 0, 0.34, 0)
FunctionList.BackgroundColor3 = UI.DarkGray
FunctionList.CanvasSize = UDim2.new(0, 0, 0, 0)
FunctionList.ScrollBarThickness = 6
FunctionList.Parent = Panel
Instance.new("UICorner", FunctionList).CornerRadius = UDim.new(0, 10)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = FunctionList

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.Parent = FunctionList

-- 📋 បង្ហាញសត្វ
for i, Creature in ipairs(Creatures) do
    local CreatureBtn = Instance.new("TextButton")
    CreatureBtn.Size = UDim2.new(1, 0, 0, 40)
    CreatureBtn.BackgroundColor3 = UI.Gray
    CreatureBtn.Text = Creature.Name .. " - " .. Creature.Value .. Creature.Unit
    CreatureBtn.TextColor3 = UI.Text
    CreatureBtn.Font = Enum.Font.GothamBold
    CreatureBtn.TextSize = 14
    CreatureBtn.Parent = FunctionList
    Instance.new("UICorner", CreatureBtn).CornerRadius = UDim.new(0, 8)
    
    CreatureBtn.MouseButton1Click:Connect(function()
        FlyTo(Creature)
    end)
end

-- 🎯 បើក/បិទ Panel
LogoBtn.MouseButton1Click:Connect(function()
    State.PanelOpen = not State.PanelOpen
    Panel.Visible = State.PanelOpen
end)

-- 🛡️ បើក/បិទ ការពារ
ProtectBtn.MouseButton1Click:Connect(function()
    State.NoKnockback = not State.NoKnockback
    State.NoDamage = State.NoKnockback
    if State.NoKnockback then
        ProtectBtn.BackgroundColor3 = UI.Green
        ProtectBtn.Text = "🛡️ គេវ៉ៃអត់ដួល៖ បើក"
    else
        ProtectBtn.BackgroundColor3 = UI.Red
        ProtectBtn.Text = "🛡️ គេវ៉ៃអត់ដួល៖ បិទ"
    end
end)

-- 🥚 បើក/បិទ បើកពងភ្លាមៗ
InstantHatchBtn.MouseButton1Click:Connect(function()
    State.InstantHatch = not State.InstantHatch
    if State.InstantHatch then
        InstantHatchBtn.BackgroundColor3 = UI.Green
        InstantHatchBtn.Text = "🥚 បើកពងភ្លាមៗ៖ បើក"
    else
        InstantHatchBtn.BackgroundColor3 = UI.Gray
        InstantHatchBtn.Text = "🥚 បើកពងភ្លាមៗ៖ បិទ"
    end
end)

-- ⏱️ បើក/បិទ បិទម៉ោងរាប់ថយ
NoCountdownBtn.MouseButton1Click:Connect(function()
    State.NoCountdown = not State.NoCountdown
    if State.NoCountdown then
        NoCountdownBtn.BackgroundColor3 = UI.Green
        NoCountdownBtn.Text = "⏱️ បិទម៉ោងរាប់ថយ៖ បើក"
    else
        NoCountdownBtn.BackgroundColor3 = UI.Gray
        NoCountdownBtn.Text = "⏱️ បិទម៉ោងរាប់ថយ៖ បិទ"
    end
end)

-- 📏 កែទំហំ Panel
local function ResizePanel()
    local TotalHeight = 55 + 45 + 45 + 45 + 200 + 20
    Panel.Size = UDim2.new(0, 420, 0, TotalHeight)
end

-- 🚀 បើកដំណើរការទាំងនេះ
local function StartHub()
    State.PanelOpen = false
    Panel.Visible = false
    LogoBtn.Visible = true
    LogoBtn.Position = UDim2.new(0.02, 0, 0.88, 0)
end

-- 📋 ប្រាប់អ្នកប្រើប្រាស់
print("បើកដំណើរការទាំងនេះ
