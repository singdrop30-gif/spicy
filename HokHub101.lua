-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ គេវៃអត់បាន! + ប៊ូតុង ON=ខៀវ | OFF=ក្រហម! OFF=ដើរធម្មតា!
-- ==========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")

-- 🎨 Colors
local UI = {
    Pink = Color3.fromRGB(255, 0, 140),
    BG = Color3.fromRGB(20, 20, 30),
    Gray = Color3.fromRGB(45, 45, 60),
    Blue = Color3.fromRGB(30, 144, 255),   -- ON = ខៀវ
    Red = Color3.fromRGB(190, 40, 60),      -- OFF = ក្រហម
    Green = Color3.fromRGB(40, 190, 70),
    White = Color3.new(1, 1, 1)
}

-- 📦 State
local State = {
    Open = false,
    OriginalSpeed = 16,        -- ល្បឿនដើមពិត
    SpeedBoostOn = false,      -- បិទ/បើកល្បឿន
    SelectedMultiplier = 2,     -- គុណល្បឿន
    NoKnockback = false,        -- គេរុញអត់បាន
    NoDamage = false,           -- គេវៃអត់បាន
    NoHitWhenStealing = false   -- យកពងគេវៃអត់បាន
}

-- 🖥️ ScreenGui
local SG = Instance.new("ScreenGui")
SG.Name = "JinghokHub"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.Parent = Gui

-- 🎯 FLOATING BUTTON: JH
local JH_BTN = Instance.new("TextButton")
JH_BTN.Size = UDim2.new(0, 55, 0, 55)
JH_BTN.Position = UDim2.new(1, -75, 1, -75)
JH_BTN.BackgroundColor3 = UI.Pink
JH_BTN.Text = "JH"
JH_BTN.Font = Enum.Font.GothamBold
JH_BTN.TextSize = 22
JH_BTN.TextColor3 = UI.White
JH_BTN.Active = true
JH_BTN.Draggable = true
JH_BTN.Parent = SG
Instance.new("UICorner", JH_BTN).CornerRadius = UDim.new(0, 12)
local JH_Glow = Instance.new("UIStroke", JH_BTN)
JH_Glow.Color = UI.Pink
JH_Glow.Thickness = 2

-- 📦 MAIN PANEL
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 340, 0, 520)
Panel.Position = UDim2.new(0.5, -170, 0.5, -260)
Panel.BackgroundColor3 = UI.BG
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SG
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", Panel).Color = UI.Pink

-- 🔝 HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = UI.Pink
Header.Parent = Panel
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💖 JINGHOK HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = UI.White
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local ClosePanelBtn = Instance.new("TextButton")
ClosePanelBtn.Size = UDim2.new(0, 40, 0, 40)
ClosePanelBtn.Position = UDim2.new(1, -45, 0, 5)
ClosePanelBtn.BackgroundTransparency = 1
ClosePanelBtn.Text = "✕"
ClosePanelBtn.Font = Enum.Font.GothamBold
ClosePanelBtn.TextSize = 20
ClosePanelBtn.TextColor3 = UI.White
ClosePanelBtn.Parent = Header

-- 🧩 Helper: បង្កើតប៊ូតុងបិទ/បើក
local function CreateToggle(yPos, icon, label, stateKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 50)
    Frame.Position = UDim2.new(0.05, 0, 0, yPos)
    Frame.BackgroundColor3 = UI.Gray
    Frame.Parent = Panel
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = icon .. " " .. label
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextColor3 = UI.White
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 60, 0, 30)
    Toggle.Position = UDim2.new(1, -72, 0.5, -15)
    Toggle.BackgroundColor3 = UI.Red
    Toggle.Text = "OFF"
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 12
    Toggle.TextColor3 = UI.White
    Toggle.Parent = Frame
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

    Toggle.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        Toggle.BackgroundColor3 = State[stateKey] and UI.Blue or UI.Red  -- ON=ខៀវ | OFF=ក្រហម
        Toggle.Text = State[stateKey] and "ON" or "OFF"
        local msg = State[stateKey] and "បើកហើយ!" or "បិទហើយ!"
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title=icon .. " " .. label, Text=msg, Duration=1.5})
        end)
    end)

    return Toggle
end

-- ⚡ ប៊ូតុងបិទ/បើកល្បឿនធំ
local SpeedMainFrame = Instance.new("Frame")
SpeedMainFrame.Size = UDim2.new(0.9, 0, 0, 60)
SpeedMainFrame.Position = UDim2.new(0.05, 0, 0, 65)
SpeedMainFrame.BackgroundColor3 = UI.Gray
SpeedMainFrame.Parent = Panel
Instance.new("UICorner", SpeedMainFrame).CornerRadius = UDim.new(0, 10)

local SpeedMainLabel = Instance.new("TextLabel")
SpeedMainLabel.Size = UDim2.new(0.55, 0, 1, 0)
SpeedMainLabel.Position = UDim2.new(0, 15, 0, 0)
SpeedMainLabel.BackgroundTransparency = 1
SpeedMainLabel.Text = "⚡ បង្កើនល្បឿន"
SpeedMainLabel.Font = Enum.Font.GothamBold
SpeedMainLabel.TextSize = 16
SpeedMainLabel.TextColor3 = UI.White
SpeedMainLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedMainLabel.Parent = SpeedMainFrame

local SpeedMainToggle = Instance.new("TextButton")
SpeedMainToggle.Size = UDim2.new(0, 110, 0, 45)
SpeedMainToggle.Position = UDim2.new(1, -125, 0.5, -22)
SpeedMainToggle.BackgroundColor3 = UI.Red   -- ដំបូង = OFF = ក្រហម
SpeedMainToggle.Text = "OFF"
SpeedMainToggle.Font = Enum.Font.GothamBold
SpeedMainToggle.TextSize = 16
SpeedMainToggle.TextColor3 = UI.White
SpeedMainToggle.Parent = SpeedMainFrame
Instance.new("UICorner", SpeedMainToggle).CornerRadius = UDim.new(0, 10)

SpeedMainToggle.MouseButton1Click:Connect(function()
    State.SpeedBoostOn = not State.SpeedBoostOn
    if State.SpeedBoostOn then
        SpeedMainToggle.BackgroundColor3 = UI.Blue  -- ON = ខៀវ
        SpeedMainToggle.Text = "ON"
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ ល្បឿន", Text="បើក x" .. State.SelectedMultiplier, Duration=1.5})
        end)
    else
        SpeedMainToggle.BackgroundColor3 = UI.Red   -- OFF = ក្រហម
        SpeedMainToggle.Text = "OFF"
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ ល្បឿន", Text="បិទ → ដើរធម្មតាវិញ", Duration=1.5})
        end)
    end
end)

-- 🎯 ជ្រើសរើសគុណល្បឿន
local MultHeader = Instance.new("TextLabel")
MultHeader.Size = UDim2.new(0.9, 0, 0, 25)
MultHeader.Position = UDim2.new(0.05, 0, 0, 145)
MultHeader.BackgroundTransparency = 1
MultHeader.Text = "🎯 ជ្រើសរើសគុណល្បឿន"
MultHeader.Font = Enum.Font.GothamBold
MultHeader.TextSize = 13
MultHeader.TextColor3 = UI.White
MultHeader.TextXAlignment = Enum.TextXAlignment.Left
MultHeader.Parent = Panel

local Multipliers = {2, 3, 5, 10, 20, 25, 30}
local MultBtns = {}

for i, mult in ipairs(Multipliers) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -6, 0, 40)
    btn.Position = UDim2.new(0.05 + ((i-1) % 4) * 0.245, 0, 0, 175 + math.floor((i-1)/4) * 50)
    btn.BackgroundColor3 = mult == State.SelectedMultiplier and UI.Green or UI.Gray
    btn.Text = "x" .. mult
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = UI.White
    btn.Parent = Panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    MultBtns[mult] = btn

    btn.MouseButton1Click:Connect(function()
        State.SelectedMultiplier = mult
        for m, b in pairs(MultBtns) do
            b.BackgroundColor3 = m == mult and UI.Green or UI.Gray
        end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ គុណល្បឿន", Text="ជ្រើសរើស x" .. mult, Duration=1.5})
        end)
    end)
end

-- 📋 មុខងារការពារ
local Toggles = {
    NoDamage = CreateToggle(290, "🛡️", "គេវៃយើងអត់បាន", "NoDamage"),
    NoHitWhenStealing = CreateToggle(350, "🥚", "យកពងគេវៃអត់បាន", "NoHitWhenStealing"),
    NoKnockback = CreateToggle(410, "💨", "គេរុញយើងអត់បាន", "NoKnockback"),
}

-- 🛡️ រារាំងការខូចខាត & ការវាយ
local function SetupProtection()
    if Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        local Root = Player.Character:FindFirstChild("HumanoidRootPart")
        if not Root then return end

        -- រារាំងការខូចខាតទាំងអស់
        if State.NoDamage or State.NoHitWhenStealing then
            -- ការពារ HP
            if Hum then
                Hum.MaxHealth = math.huge
                Hum.Health = math.huge
            end
            
            -- រារាំង Touch/Projectile/Weapon ទាំងអស់
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                    part.CollisionGroup = "Players"
                end
            end
            
            -- រារាំងការវាយពីអ្នកដទៃ
            Root.Touched:Connect(function(hit)
                if State.NoDamage or State.NoHitWhenStealing then
                    return false  -- បដិសេធការប៉ះទាំងអស់
                end
            end)
        end
    end
end

-- 🎯 បើក/បិទម៉ឺនុយ
local function ToggleMenu()
    State.Open = not State.Open
    Panel.Visible = State.Open
end

JH_BTN.MouseButton1Click:Connect(ToggleMenu)
ClosePanelBtn.MouseButton1Click:Connect(ToggleMenu)

-- ⌨️ ក្តារចុច
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then ToggleMenu() end
end)

-- 🔄 ដំណើរការជានិច្ច
RunService.Heartbeat:Connect(function()
    if Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            -- កត់ត្រាល្បឿនដើមពិត
            if State.OriginalSpeed == 16 then
                State.OriginalSpeed = Hum.WalkSpeed
            end
            
            -- បើក = គុណ | បិទ = ត្រឡប់ដើមវិញ
            if State.SpeedBoostOn then
                Hum.WalkSpeed = State.OriginalSpeed * State.SelectedMultiplier
            else
                Hum.WalkSpeed = State.OriginalSpeed
            end

            -- 💨 No Knockback
            if State.NoKnockback then
                Hum:SetStateEnabled(Enum.HumanoidStateType.KnockedBack, false)
            else
                Hum:SetStateEnabled(Enum.HumanoidStateType.KnockedBack, true)
            end

            -- 🛡️ No Damage
            if State.NoDamage or State.NoHitWhenStealing then
                Hum.MaxHealth = math.huge
                Hum.Health = math.huge
            end
        end

        -- 🛡️ ការពារការប៉ះ/វាយ
        SetupProtection()
    end
end)

-- ✅ រួចរាល់
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ គេវៃអត់បាន! + យកពងគេវៃអត់បាន! + ON=ខៀវ OFF=ក្រហម!", Duration=3})
end)
print("💖 JINGHOK HUB | READY | គេវៃអត់បាន! + យកពងគេវៃអត់បាន!")
