-- ==========================================
-- 💖 JINGHOK HUB | STEAL AN EGG
-- ✅ បើកភ្លាមៗ! មិនចាំម៉ោងទាល់តែសោះ! + គុណល្បឿន x2-x30!
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
    InstantHatch = false,   -- បើកភ្លាមៗ
    NoCountdown = false,    -- បិទម៉ោងរាប់ថយក្រោយ
    ESP_Eggs = false,       -- មើលពង
    AutoSteal = false,      -- យកពងស្វ័យប្រវត្តិ
    NoKnockback = false     -- អត់រុញ
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

-- 🧩 Helper Function: បង្កើតប៊ូតុងបិទ/បើក
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
        if State[stateKey] then
            Toggle.BackgroundColor3 = UI.Green
            Toggle.Text = "ON"
        else
            Toggle.BackgroundColor3 = UI.Red
            Toggle.Text = "OFF"
        end
    end)

    return Toggle
end

-- 📋 ប៊ូតុងទាំងអស់
local Toggles = {
    ESP_Eggs = CreateToggle(65, "🥚", "ESP Eggs (បង្ហាញពង)", "ESP_Eggs"),
    AutoSteal = CreateToggle(125, "🥚", "Auto Steal (យកដោយស្វ័យប្រវត្តិ)", "AutoSteal"),
    InstantHatch = CreateToggle(185, "🥚", "Instant Hatch (បើកភ្លាមៗ)", "InstantHatch"),
    NoCountdown = CreateToggle(245, "⏱️", "No Countdown (បិទម៉ោងរាប់ថយក្រោយ)", "NoCountdown"),
    NoKnockback = CreateToggle(305, "🛡️", "No Knockback (គេមិនអាចរុញបាន)", "NoKnockback"),
}

-- ⚡ គុណល្បឿន
local SpeedHeader = Instance.new("TextLabel")
SpeedHeader.Size = UDim2.new(0.9, 0, 0, 30)
SpeedHeader.Position = UDim2.new(0.05, 0, 0, 370)
SpeedHeader.BackgroundTransparency = 1
SpeedHeader.Text = "⚡ គុណល្បឿន"
SpeedHeader.Font = Enum.Font.GothamBold
SpeedHeader.TextSize = 14
SpeedHeader.TextColor3 = UI.White
SpeedHeader.TextXAlignment = Enum.TextXAlignment.Left
SpeedHeader.Parent = Panel

local Multipliers = {2, 3, 5, 10, 20, 30}
local MultBtns = {}

for i, mult in ipairs(Multipliers) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.28, -5, 0, 40)
    btn.Position = UDim2.new(0.05 + ((i-1) % 3) * 0.32, 0, 0, 405 + math.floor((i-1)/3) * 50)
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

-- 🥚 Instant Hatch + No Countdown
local function ProcessEggs()
    for _, obj in pairs(WS:GetDescendants()) do
        -- 🥚 បិទម៉ោងរាប់ថយក្រោយ
        if State.NoCountdown then
            if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                local n = string.lower(obj.Name)
                if string.find(n, "time") or string.find(n, "timer") or string.find(n, "countdown") 
                or string.find(n, "hatch") or string.find(n, "grow") or string.find(n, "egg") then
                    obj.Value = 0 -- ⚡ កំណត់ម៉ោងទៅ 0 = ចប់ភ្លាមៗ!
                end
            end
            -- លាក់អត្ថបទម៉ោង
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local t = string.lower(obj.Text)
                if string.find(t, "h") and string.find(t, "m") or string.find(t, "hour") 
                or string.find(t, "minute") or string.find(t, "second") then
                    obj.Text = "✅ រួចរាល់!"
                end
            end
        end

        -- 🥚 បើកភ្លាមៗ
        if State.InstantHatch then
            if obj:IsA("BasePart") and string.find(string.lower(obj.Name), "egg") then
                pcall(function()
                    -- ប៉ះពងដើម្បីបើក
                    local fire = Instance.new("BindableEvent")
                    fire.Name = "Touched"
                    fire:Fire()
                end)
            end
        end
    end

    -- បិទម៉ោងក្នុង PlayerGui ទាំងអស់
    if State.NoCountdown then
        for _, obj in pairs(Player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local t = string.lower(obj.Text)
                if string.find(t, "h") and string.find(t, "m") or string.find(t, "hour") 
                or string.find(t, "minute") or string.find(t, "second") then
                    obj.Text = "✅ រួចរាល់!"
                end
            end
        end
    end
end

-- 🛡️ No Knockback
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
    -- ⚡ គុណល្បឿន
    if Player.Character then
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then
            Hum.WalkSpeed = 16 * State.SpeedMultiplier
        end
    end

    -- 🥚 បើកភ្លាមៗ + បិទម៉ោង
    if State.InstantHatch or State.NoCountdown then
        ProcessEggs()
    end

    -- 🛡️ អត់រុញ
    UpdateNoKnockback()
end)

-- ✅ រួចរាល់
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ Instant Hatch + No Countdown! បើកភ្លាមៗ!", Duration=3})
end)
print("💖 JINGHOK HUB | READY | Instant Hatch + No Countdown + Speed Multiplier!")
