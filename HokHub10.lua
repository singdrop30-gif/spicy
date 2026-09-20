-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ គុណល្បឿន 2x 3x 5x 10x 20x 30x + ម៉ោងពង ១ នាទី!
-- ==========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local WS = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")

-- 🎨 Colors
local UI = {
    Pink = Color3.fromRGB(255, 0, 140),
    BG = Color3.fromRGB(20, 20, 30),
    Gray = Color3.fromRGB(45, 45, 60),
    Green = Color3.fromRGB(40, 190, 70),
    Red = Color3.fromRGB(190, 40, 60),
    White = Color3.new(1, 1, 1)
}

-- 📦 State
local State = {
    Open = false,
    SpeedMultiplier = 1,
    SpeedEnabled = false,
    FastHatch = false
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
Panel.Size = UDim2.new(0, 320, 0, 420)
Panel.Position = UDim2.new(0.5, -160, 0.5, -210)
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

-- 🥚 បើកពង ១ នាទី | ON/OFF
local HatchFrame = Instance.new("Frame")
HatchFrame.Size = UDim2.new(0.9, 0, 0, 45)
HatchFrame.Position = UDim2.new(0.05, 0, 0, 65)
HatchFrame.BackgroundColor3 = UI.Gray
HatchFrame.Parent = Panel
Instance.new("UICorner", HatchFrame).CornerRadius = UDim.new(0, 8)

local HatchLabel = Instance.new("TextLabel")
HatchLabel.Size = UDim2.new(0.6, 0, 1, 0)
HatchLabel.Position = UDim2.new(0, 12, 0, 0)
HatchLabel.BackgroundTransparency = 1
HatchLabel.Text = "🥚 បើកពង ១ នាទី"
HatchLabel.Font = Enum.Font.GothamBold
HatchLabel.TextSize = 15
HatchLabel.TextColor3 = UI.White
HatchLabel.TextXAlignment = Enum.TextXAlignment.Left
HatchLabel.Parent = HatchFrame

local HatchToggle = Instance.new("TextButton")
HatchToggle.Size = UDim2.new(0, 60, 0, 28)
HatchToggle.Position = UDim2.new(1, -72, 0.5, -14)
HatchToggle.BackgroundColor3 = UI.Red
HatchToggle.Text = "OFF"
HatchToggle.Font = Enum.Font.GothamBold
HatchToggle.TextSize = 12
HatchToggle.TextColor3 = UI.White
HatchToggle.Parent = HatchFrame
Instance.new("UICorner", HatchToggle).CornerRadius = UDim.new(0, 6)

-- ⚡ គុណល្បឿន
local SpeedHeader = Instance.new("TextLabel")
SpeedHeader.Size = UDim2.new(0.9, 0, 0, 30)
SpeedHeader.Position = UDim2.new(0.05, 0, 0, 130)
SpeedHeader.BackgroundTransparency = 1
SpeedHeader.Text = "⚡ គុណល្បឿន"
SpeedHeader.Font = Enum.Font.GothamBold
SpeedHeader.TextSize = 14
SpeedHeader.TextColor3 = UI.White
SpeedHeader.TextXAlignment = Enum.TextXAlignment.Left
SpeedHeader.Parent = Panel

-- 🎯 ប៊ូតុងគុណល្បឿន
local Multipliers = {2, 3, 5, 10, 20, 30}
local MultBtns = {}

for i, mult in ipairs(Multipliers) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.28, -5, 0, 40)
    btn.Position = UDim2.new(0.05 + ((i-1) % 3) * 0.32, 0, 0, 170 + math.floor((i-1)/3) * 50)
    btn.BackgroundColor3 = UI.Gray
    btn.Text = "x" .. mult
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = UI.White
    btn.Parent = Panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    MultBtns[mult] = btn

    btn.MouseButton1Click:Connect(function()
        State.SpeedMultiplier = mult
        for m, b in pairs(MultBtns) do
            b.BackgroundColor3 = m == mult and UI.Green or UI.Gray
        end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ គុណល្បឿន", Text="x" .. mult, Duration=1.5})
        end)
    end)
end

-- 🥚 កាត់ម៉ោងពង
local function SetAllEggTimes()
    for _, obj in pairs(WS:GetDescendants()) do
        if obj:IsA("NumberValue") or obj:IsA("IntValue") then
            local n = string.lower(obj.Name)
            if string.find(n, "time") or string.find(n, "timer") or string.find(n, "hatch") 
            or string.find(n, "grow") or string.find(n, "countdown") or string.find(n, "egg") then
                obj.Value = 60
            end
        end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local t = string.lower(obj.Text)
            if string.find(t, "h") and string.find(t, "m") or string.find(t, "hour") then
                obj.Text = "1m"
            end
        end
    end
    for _, obj in pairs(Player.PlayerGui:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local t = string.lower(obj.Text)
            if string.find(t, "h") and string.find(t, "m") or string.find(t, "hour") then
                obj.Text = "1m"
            end
        end
    end
end

HatchToggle.MouseButton1Click:Connect(function()
    State.FastHatch = not State.FastHatch
    if State.FastHatch then
        HatchToggle.BackgroundColor3 = UI.Green
        HatchToggle.Text = "ON"
        SetAllEggTimes()
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="🥚 បើកពង", Text="ម៉ោង ១ នាទី!", Duration=2})
        end)
    else
        HatchToggle.BackgroundColor3 = UI.Red
        HatchToggle.Text = "OFF"
    end
end)

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

-- 🔄 អនុវត្តគុណល្បឿន + រក្សាម៉ោងពង
RunService.Heartbeat:Connect(function()
    -- ⚡ គុណល្បឿន
    if Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            Hum.WalkSpeed = 16 * State.SpeedMultiplier
        end
    end
    -- 🥚 រក្សាម៉ោងពង ១ នាទី
    if State.FastHatch then
        SetAllEggTimes()
    end
end)

-- ✅ រួចរាល់
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ រួចរាល់! x2-x30 + ពង ១ នាទី!", Duration=3})
end)
print("💖 JINGHOK HUB | READY | x2 x3 x5 x10 x20 x30 + ពង ១ នាទី!")
