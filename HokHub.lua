local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")

-- 🎨 Colors
local UI = {
    Pink = Color3.fromRGB(255, 0, 140),
    PinkDark = Color3.fromRGB(180, 0, 100),
    BG = Color3.fromRGB(20, 20, 30),
    Dark = Color3.fromRGB(12, 12, 20),
    Gray = Color3.fromRGB(45, 45, 60),
    Green = Color3.fromRGB(40, 190, 70),
    Red = Color3.fromRGB(190, 40, 60),
    White = Color3.new(1, 1, 1)
}

-- 📦 State
local State = {
    Open = false,
    ESP = false,
    AutoSteal = false,
    InstantHatch = false,
    NoCountdown = false,
    NoKnockback = true,
    Speed = 1000
}

-- 🥚 Egg List
local Eggs = {
    {Name = "Imp", Value = "17.1M/s", Rarity = "Mythic", Color = Color3.fromRGB(255, 80, 220)},
    {Name = "Kraken", Value = "13.1M/s", Rarity = "Mythic", Color = Color3.fromRGB(255, 80, 220)},
    {Name = "Beluga Whale", Value = "3.3M/s", Rarity = "Legendary", Color = Color3.fromRGB(255, 200, 40)},
    {Name = "Toro", Value = "3.2M/s", Rarity = "Legendary", Color = Color3.fromRGB(255, 200, 40)},
    {Name = "Bladehide", Value = "2.4M/s", Rarity = "Legendary", Color = Color3.fromRGB(255, 200, 40)},
    {Name = "Winged Lamb", Value = "1.3M/s", Rarity = "Epic", Color = Color3.fromRGB(180, 80, 255)}
}

-- 🖥️ ScreenGui
local SG = Instance.new("ScreenGui")
SG.Name = "JinghokHub"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.Parent = Gui

-- 🎯 FLOATING BUTTON: JH (តែមួយគត់!)
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

-- ❎ CLOSE ALL BUTTON
local CLOSE_ALL_BTN = Instance.new("TextButton")
CLOSE_ALL_BTN.Size = UDim2.new(0, 45, 0, 45)
CLOSE_ALL_BTN.Position = UDim2.new(1, -130, 1, -75)
CLOSE_ALL_BTN.BackgroundColor3 = UI.Red
CLOSE_ALL_BTN.Text = "❎"
CLOSE_ALL_BTN.Font = Enum.Font.GothamBold
CLOSE_ALL_BTN.TextSize = 18
CLOSE_ALL_BTN.TextColor3 = UI.White
CLOSE_ALL_BTN.Active = true
CLOSE_ALL_BTN.Draggable = true
CLOSE_ALL_BTN.Parent = SG
Instance.new("UICorner", CLOSE_ALL_BTN).CornerRadius = UDim.new(0, 10)

-- 📦 MAIN PANEL
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 420, 0, 560)
Panel.Position = UDim2.new(0.5, -210, 0.5, -280)
Panel.BackgroundColor3 = UI.BG
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SG
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 14)
local PanelStroke = Instance.new("UIStroke", Panel)
PanelStroke.Color = UI.Pink

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

-- 🔘 TOGGLE FUNCTION
local function MakeToggle(y, label, stateKey)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0.9, 0, 0, 42)
    f.Position = UDim2.new(0.05, 0, 0, y)
    f.BackgroundColor3 = UI.Gray
    f.Parent = Panel
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(0.7, 0, 1, 0)
    txt.Position = UDim2.new(0, 12, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = label
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 14
    txt.TextColor3 = UI.White
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = f

    local tgl = Instance.new("TextButton")
    tgl.Size = UDim2.new(0, 60, 0, 28)
    tgl.Position = UDim2.new(1, -70, 0.5, -14)
    tgl.BackgroundColor3 = State[stateKey] and UI.Green or UI.Red
    tgl.Text = State[stateKey] and "ON" or "OFF"
    tgl.Font = Enum.Font.GothamBold
    tgl.TextSize = 12
    tgl.TextColor3 = UI.White
    tgl.Parent = f
    Instance.new("UICorner", tgl).CornerRadius = UDim.new(0, 6)

    tgl.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        tgl.BackgroundColor3 = State[stateKey] and UI.Green or UI.Red
        tgl.Text = State[stateKey] and "ON" or "OFF"
    end)
    return tgl
end

-- 📋 CREATE TOGGLES
MakeToggle(65, "🥚 ESP Eggs (បង្ហាញពង)", "ESP")
MakeToggle(115, "🥚 Auto Steal (យកដោយស្វ័យ)", "AutoSteal")
MakeToggle(165, "🐣 Instant Hatch (បើកពងភ្លាម)", "InstantHatch")
MakeToggle(215, "⏱️ No Countdown (បិទម៉ោងរាប់)", "NoCountdown")
MakeToggle(265, "🛡️ No Knockback (គេវ៉ៃអត់ដួល)", "NoKnockback")

-- ⚡ SPEED CONTROLS
local SpdLbl = Instance.new("TextLabel")
SpdLbl.Size = UDim2.new(0.9, 0, 0, 30)
SpdLbl.Position = UDim2.new(0.05, 0, 0, 315)
SpdLbl.BackgroundTransparency = 1
SpdLbl.Text = "⚡ ល្បឿនរត់: " .. State.Speed
SpdLbl.Font = Enum.Font.GothamBold
SpdLbl.TextSize = 14
SpdLbl.TextColor3 = UI.Pink
SpdLbl.TextXAlignment = Enum.TextXAlignment.Left
SpdLbl.Parent = Panel

local Speeds = {50, 100, 500, 1000, 2000}
local SpdBtns = {}
for i, spd in ipairs(Speeds) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.17, -4, 0, 38)
    b.Position = UDim2.new(0.05 + (i-1)*0.19, 0, 0, 350)
    b.BackgroundColor3 = spd == State.Speed and UI.Green or UI.Gray
    b.Text = tostring(spd)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = UI.White
    b.Parent = Panel
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    SpdBtns[spd] = b
    b.MouseButton1Click:Connect(function()
        State.Speed = spd
        SpdLbl.Text = "⚡ ល្បឿនរត់: " .. spd
        for s, btn in pairs(SpdBtns) do
            btn.BackgroundColor3 = s == spd and UI.Green or UI.Gray
        end
    end)
end

-- 🥚 EGG LIST
local ListLbl = Instance.new("TextLabel")
ListLbl.Size = UDim2.new(0.9, 0, 0, 28)
ListLbl.Position = UDim2.new(0.05, 0, 0, 400)
ListLbl.BackgroundTransparency = 1
ListLbl.Text = "📋 បញ្ជីពង (ចុចយក)"
ListLbl.Font = Enum.Font.GothamBold
ListLbl.TextSize = 14
ListLbl.TextColor3 = UI.White
ListLbl.TextXAlignment = Enum.TextXAlignment.Left
ListLbl.Parent = Panel

local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(0.9, 0, 0, 130)
List.Position = UDim2.new(0.05, 0, 0, 425)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 5
List.CanvasSize = UDim2.new(0, 0, 0, #Eggs * 42)
List.Parent = Panel

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.Parent = List

for _, egg in ipairs(Eggs) do
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, -5, 0, 36)
    item.BackgroundColor3 = UI.Gray
    item.Parent = List
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)

    local nm = Instance.new("TextLabel")
    nm.Size = UDim2.new(0.55, 0, 1, 0)
    nm.Position = UDim2.new(0, 10, 0, 0)
    nm.BackgroundTransparency = 1
    nm.Text = egg.Name
    nm.Font = Enum.Font.GothamBold
    nm.TextSize = 13
    nm.TextColor3 = egg.Color
    nm.TextXAlignment = Enum.TextXAlignment.Left
    nm.Parent = item

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(0.25, 0, 1, 0)
    val.Position = UDim2.new(0.55, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = "$" .. egg.Value
    val.Font = Enum.Font.Gotham
    val.TextSize = 11
    val.TextColor3 = Color3.fromRGB(120, 255, 120)
    val.Parent = item

    local get = Instance.new("TextButton")
    get.Size = UDim2.new(0.18, 0, 0, 28)
    get.Position = UDim2.new(0.80, 0, 0.5, -14)
    get.BackgroundColor3 = UI.Green
    get.Text = "យក"
    get.Font = Enum.Font.GothamBold
    get.TextSize = 12
    get.TextColor3 = UI.White
    get.Parent = item
    Instance.new("UICorner", get).CornerRadius = UDim.new(0, 5)

    get.MouseButton1Click:Connect(function()
        get.Text = "ទៅ!"
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title="Jinghok Hub", Text="កំពុងទៅយក "..egg.Name, Duration=2})
        end)
        task.delay(1.5, function() get.Text = "យក" end)
    end)
end

-- 🎯 TOGGLE MENU OPEN/CLOSE
local function ToggleMenu()
    State.Open = not State.Open
    Panel.Visible = State.Open
end

-- ❎ CLOSE ALL FUNCTION
local function CloseAll()
    State.Open = false
    Panel.Visible = false
    State.ESP = false
    State.AutoSteal = false
    State.InstantHatch = false
    State.NoCountdown = false
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title="❎ បិទទាំងអស់", Text="មុខងារទាំងអស់បានបិទ!", Duration=2})
    end)
    print("❎ ALL CLOSED")
end

-- 🖱️ CONNECT BUTTONS
JH_BTN.MouseButton1Click:Connect(ToggleMenu)
ClosePanelBtn.MouseButton1Click:Connect(ToggleMenu)
CLOSE_ALL_BTN.MouseButton1Click:Connect(CloseAll)

-- ⌨️ KEYBOARD SHORTCUTS
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ToggleMenu()
    end
    if input.KeyCode == Enum.KeyCode.Delete then
        CloseAll()
    end
end)

-- 🛡️ SAFETY LOOPS
game:GetService("RunService").Stepped:Connect(function()
    if State.NoKnockback and Player.Character then
        local root = Player.Character:FindFirstChild("HumanoidRootPart")
        if root then root.Velocity = Vector3.new(root.Velocity.X * 0.05, root.Velocity.Y, root.Velocity.Z * 0.05) end
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then hum.MaxHealth = math.huge; hum.Health = math.huge end
    end
    if State.NoCountdown or State.InstantHatch then
        for _, v in pairs(WS:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n = string.lower(v.Name)
                if string.find(n, "countdown") or string.find(n, "timer") or string.find(n, "time") or string.find(n, "hatch") then
                    v.Value = 0
                end
            end
        end
    end
end)

-- ✅ READY NOTIFICATION
pcall(function()
    StarterGui:SetCore("SendNotification", {Title="💖 JINGHOK HUB", Text="✅ រួចរាល់! JH=បើក  ❎=បិទទាំងអស់", Duration=4})
end)
print("💖 JINGHOK HUB READY! | JH = Open Menu | ❎ = Close All | Delete Key = Close All")
