-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ គុណល្បឿនពិតក្នុងហ្គេម! មិនគុណ 16!
-- ==========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
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
    OriginalSpeed = 16,  -- រក្សាល្បឿនដើមពិត
    SpeedMultiplier = 1,
    NoKnockback = false
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
Panel.Size = UDim2.new(0, 340, 0, 320)
Panel.Position = UDim2.new(0.5, -170, 0.5, -160)
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

-- 🛡️ No Knockback
local NKFrame = Instance.new("Frame")
NKFrame.Size = UDim2.new(0.9, 0, 0, 50)
NKFrame.Position = UDim2.new(0.05, 0, 0, 65)
NKFrame.BackgroundColor3 = UI.Gray
NKFrame.Parent = Panel
Instance.new("UICorner", NKFrame).CornerRadius = UDim.new(0, 8)

local NKLabel = Instance.new("TextLabel")
NKLabel.Size = UDim2.new(0.7, 0, 1, 0)
NKLabel.Position = UDim2.new(0, 12, 0, 0)
NKLabel.BackgroundTransparency = 1
NKLabel.Text = "🛡️ No Knockback (គេមិនអាចរុញបាន)"
NKLabel.Font = Enum.Font.GothamBold
NKLabel.TextSize = 14
NKLabel.TextColor3 = UI.White
NKLabel.TextXAlignment = Enum.TextXAlignment.Left
NKLabel.Parent = NKFrame

local NKToggle = Instance.new("TextButton")
NKToggle.Size = UDim2.new(0, 60, 0, 30)
NKToggle.Position = UDim2.new(1, -72, 0.5, -15)
NKToggle.BackgroundColor3 = UI.Red
NKToggle.Text = "OFF"
NKToggle.Font = Enum.Font.GothamBold
NKToggle.TextSize = 12
NKToggle.TextColor3 = UI.White
NKToggle.Parent = NKFrame
Instance.new("UICorner", NKToggle).CornerRadius = UDim.new(0, 6)

NKToggle.MouseButton1Click:Connect(function()
    State.NoKnockback = not State.NoKnockback
    NKToggle.BackgroundColor3 = State.NoKnockback and UI.Green or UI.Red
    NKToggle.Text = State.NoKnockback and "ON" or "OFF"
end)

-- ⚡ គុណល្បឿន
local SpeedHeader = Instance.new("TextLabel")
SpeedHeader.Size = UDim2.new(0.9, 0, 0, 30)
SpeedHeader.Position = UDim2.new(0.05, 0, 0, 130)
SpeedHeader.BackgroundTransparency = 1
SpeedHeader.Text = "⚡ គុណល្បឿនពិតក្នុងហ្គេម"
SpeedHeader.Font = Enum.Font.GothamBold
SpeedHeader.TextSize = 14
SpeedHeader.TextColor3 = UI.White
SpeedHeader.TextXAlignment = Enum.TextXAlignment.Left
SpeedHeader.Parent = Panel

-- 🎯 ជម្រើសគុណល្បឿន
local Multipliers = {
    {val = 1,  text = "OFF"},
    {val = 2,  text = "x2"},
    {val = 3,  text = "x3"},
    {val = 5,  text = "x5"},
    {val = 10, text = "x10"},
    {val = 20, text = "x20"},
    {val = 25, text = "x25"},
    {val = 30, text = "x30"},
}
local MultBtns = {}

for i, data in ipairs(Multipliers) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.22, -5, 0, 40)
    btn.Position = UDim2.new(0.05 + ((i-1) % 4) * 0.24, 0, 0, 165 + math.floor((i-1)/4) * 50)
    btn.BackgroundColor3 = data.val == 1 and UI.Green or UI.Gray
    btn.Text = data.text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = UI.White
    btn.Parent = Panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    MultBtns[data.val] = btn

    btn.MouseButton1Click:Connect(function()
        State.SpeedMultiplier = data.val
        for v, b in pairs(MultBtns) do
            b.BackgroundColor3 = v == data.val and UI.Green or UI.Gray
        end
        local msg = data.val == 1 and "ល្បឿនដើមវិញ" or "គុណ " .. data.text
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="⚡ ល្បឿន", Text=msg, Duration=1.5})
        end)
    end)
end

-- 🛡️ Update No Knockback
local function UpdateNoKnockback()
    if State.NoKnockback and Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            Hum:SetStateEnabled(Enum.HumanoidStateType.KnockedBack, false)
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
    -- រក្សាល្បឿនដើមពិត ពេលទើបចូល
    if Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            -- កត់ត្រាល្បឿនដើមពិត ពេលទើបចូល
            if State.SpeedMultiplier == 1 then
                State.OriginalSpeed = Hum.WalkSpeed
            end
            -- គុណល្បឿនពិត = ល្បឿនដើមរបស់អ្នក × ចំនួនគុណ
            Hum.WalkSpeed = State.OriginalSpeed * State.SpeedMultiplier
        end
    end

    -- 🛡️ អត់រុញ
    UpdateNoKnockback()
end)

-- ✅ រួចរាល់
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ គុណល្បឿនពិត! មិនមែនគុណ 16!", Duration=3})
end)
print("💖 JINGHOK HUB | READY | គុណល្បឿនពិតក្នុងហ្គេម!")
