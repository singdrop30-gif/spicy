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
    Speed = 16,
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
Panel.Size = UDim2.new(0, 320, 0, 340)
Panel.Position = UDim2.new(0.5, -160, 0.5, -170)
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

-- ⚡ ល្បឿនរត់ | ON/OFF
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 45)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, 120)
SpeedFrame.BackgroundColor3 = UI.Gray
SpeedFrame.Parent = Panel
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.6, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0, 12, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "⚡ ល្បឿនរត់"
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 15
SpeedLabel.TextColor3 = UI.White
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedFrame

local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Size = UDim2.new(0, 60, 0, 28)
SpeedToggle.Position = UDim2.new(1, -72, 0.5, -14)
SpeedToggle.BackgroundColor3 = UI.Red
SpeedToggle.Text = "OFF"
SpeedToggle.Font = Enum.Font.GothamBold
SpeedToggle.TextSize = 12
SpeedToggle.TextColor3 = UI.White
SpeedToggle.Parent = SpeedFrame
Instance.new("UICorner", SpeedToggle).CornerRadius = UDim.new(0, 6)

-- 🎯 ជម្រើសល្បឿន
local Speeds = {500, 2000, 5000, 10000, 20000}
local SpdBtns = {}

for i, spd in ipairs(Speeds) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.17, -4, 0, 40)
    btn.Position = UDim2.new(0.05 + ((i-1) % 5) * 0.19, 0, 0, 190 + math.floor((i-1)/5) * 50)
    btn.BackgroundColor3 = UI.Gray
    btn.Text = tostring(spd)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = UI.White
    btn.Parent = Panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    SpdBtns[spd] = btn

    btn.MouseButton1Click:Connect(function()
        State.Speed = spd
        for s, b in pairs(SpdBtns) do
            b.BackgroundColor3 = s == spd and UI.Green or UI.Gray
        end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ ល្បឿន", Text="កំណត់: " .. spd, Duration=1.5})
        end)
    end)
end

-- 🥚 បិទ/បើក បើកពង
HatchToggle.MouseButton1Click:Connect(function()
    State.FastHatch = not State.FastHatch
    if State.FastHatch then
        HatchToggle.BackgroundColor3 = UI.Green
        HatchToggle.Text = "ON"
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="🥚 បើកពង", Text="រង់ចាំតែ ១ នាទី!", Duration=2})
        end)
    else
        HatchToggle.BackgroundColor3 = UI.Red
        HatchToggle.Text = "OFF"
    end
end)

-- ⚡ បិទ/បើក ល្បឿនរត់
SpeedToggle.MouseButton1Click:Connect(function()
    State.SpeedEnabled = not State.SpeedEnabled
    if State.SpeedEnabled then
        SpeedToggle.BackgroundColor3 = UI.Green
        SpeedToggle.Text = "ON"
    else
        SpeedToggle.BackgroundColor3 = UI.Red
        SpeedToggle.Text = "OFF"
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
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

-- 🔄 ដំណើរការជានិច្ច
RunService.RenderStepped:Connect(function()
    -- ⚡ ល្បឿនរត់
    if State.SpeedEnabled and Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            Hum.WalkSpeed = State.Speed
        end
    end

    -- 🥚 បើកពង ១ នាទី
    if State.FastHatch then
        for _, v in pairs(WS:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n = string.lower(v.Name)
                if string.find(n, "hatch") or string.find(n, "timer") or string.find(n, "countdown") or string.find(n, "time") then
                    if v.Value > 60 then
                        v.Value = 60
                    end
                end
            end
        end
    end
end)

-- ✅ រួចរាល់
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ រួចរាល់! ទាំងអស់មាន ON/OFF", Duration=3})
end)
print("💖 JINGHOK HUB | READY | Speed + Fast Hatch | ON/OFF")
