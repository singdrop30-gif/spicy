local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")
local Character, Humanoid, RootPart, Camera

-- 🎨 ពណ៌ UI
local UI = {
    Primary = Color3.fromRGB(255, 0, 140),
    Secondary = Color3.fromRGB(200, 0, 110),
    BG = Color3.fromRGB(22, 22, 30),
    Darker = Color3.fromRGB(15, 15, 22),
    Button = Color3.fromRGB(200, 20, 60),
    ButtonHover = Color3.fromRGB(230, 40, 80),
    Green = Color3.fromRGB(40, 200, 60),
    Red = Color3.fromRGB(200, 40, 60),
    Gray = Color3.fromRGB(50, 50, 65),
    Text = Color3.new(1, 1, 1),
    Border = Color3.fromRGB(80, 80, 100)
}

-- 📦 ស្ថានភាពទាំងអស់
local State = {
    HubOpen = false,
    ActiveTab = "Farm",
    
    -- ESP Settings
    ESP_Enabled = false,
    ESP_FixedSize = false,
    ESP_ShowOwnBase = true,
    ESP_MinRarity = 5, -- 1=Common, 5=Legendary
    ESP_ShowInfo = true,
    ESP_MinValue = 0,
    ESP_Size = 75,
    
    -- Auto Steal Settings
    AutoSteal_Enabled = false,
    AutoSteal_TargetAreas = 2,
    AutoSteal_MinRarity = 0, -- Any
    AutoSteal_MinValue = 1000, -- M/s
    AutoSteal_TargetEggs = "All",
    AutoSteal_PrioritizeRift = false,
    TweenSpeed = 1000,
    
    -- Anti Guard / Safety
    AntiGuard = false,
    LastStealTime = 0,
    StealCooldown = 0.8
}

-- 🥐 ថ្នាក់ភាពកម្រ Egg
local RarityOrder = {
    [1] = {Name = "Common", Color = Color3.fromRGB(180, 180, 180)},
    [2] = {Name = "Uncommon", Color = Color3.fromRGB(80, 220, 80)},
    [3] = {Name = "Rare", Color = Color3.fromRGB(80, 140, 255)},
    [4] = {Name = "Epic", Color = Color3.fromRGB(180, 80, 255)},
    [5] = {Name = "Legendary", Color = Color3.fromRGB(255, 200, 40)},
    [6] = {Name = "Mythic", Color = Color3.fromRGB(255, 80, 220)}
}

-- 🐾 បញ្ជីសត្វ/ពង
local EggList = {
    {Name = "Imp", Value = 17.1, Unit = "M/s", Rarity = 6, Icon = "😈"},
    {Name = "Kraken", Value = 13.1, Unit = "M/s", Rarity = 6, Icon = "🐙"},
    {Name = "Beluga Whale", Value = 3.3, Unit = "M/s", Rarity = 5, Icon = "🐋"},
    {Name = "Toro", Value = 3.2, Unit = "M/s", Rarity = 5, Icon = "🐂"},
    {Name = "Bladehide", Value = 2.4, Unit = "M/s", Rarity = 5, Icon = "🦎"},
    {Name = "Winged Lamb", Value = 1.3, Unit = "M/s", Rarity = 4, Icon = "🐑"}
}

-- 🖥️ GUI Main Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JinghokHub"
ScreenGui.Parent = Gui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- 🎯 Floating Button (JH)
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "JinghokBtn"
FloatingBtn.Size = UDim2.new(0, 55, 0, 55)
FloatingBtn.Position = UDim2.new(1, -75, 1, -75)
FloatingBtn.BackgroundColor3 = UI.Primary
FloatingBtn.Text = "JH"
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.TextSize = 22
FloatingBtn.TextColor3 = UI.Text
FloatingBtn.Active = true
FloatingBtn.Draggable = true
FloatingBtn.Parent = ScreenGui
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(0, 12)

-- 📦 Main Window
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 720, 0, 520)
MainWindow.Position = UDim2.new(0.5, -360, 0.5, -260)
MainWindow.BackgroundColor3 = UI.BG
MainWindow.BorderSizePixel = 2
MainWindow.BorderColor3 = UI.Primary
MainWindow.Visible = false
MainWindow.Active = true
MainWindow.Draggable = true
MainWindow.ClipsDescendants = true
MainWindow.Parent = ScreenGui
Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 16)

-- 🔝 Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = UI.Primary
Header.Parent = MainWindow

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💖 JINGHOK HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = UI.Text
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.TextColor3 = UI.Text
CloseBtn.Parent = Header

-- 📌 Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = UI.Darker
Sidebar.Parent = MainWindow

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Top
SidebarLayout.PaddingTop = UDim.new(0, 8)
SidebarLayout.Parent = Sidebar

-- 📄 Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -140, 1, -50)
ContentArea.Position = UDim2.new(0, 140, 0, 50)
ContentArea.BackgroundColor3 = UI.BG
ContentArea.Parent = MainWindow

-- ==========================================
-- 🧩 CREATE TAB BUTTONS
-- ==========================================
local TabButtons = {}
local TabNames = {"Farm", "Player", "Predictor", "Progress", "Server", "Misc"}

for _, TabName in ipairs(TabNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 42)
    TabBtn.BackgroundColor3 = UI.Button
    TabBtn.Text = TabName
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 15
    TabBtn.TextColor3 = UI.Text
    TabBtn.Parent = Sidebar
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    
    TabButtons[TabName] = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        State.ActiveTab = TabName
        for Name, Btn in pairs(TabButtons) do
            Btn.BackgroundColor3 = UI.Button
        end
        TabBtn.BackgroundColor3 = UI.Primary
        ShowTabContent(TabName)
    end)
end

-- ==========================================
-- 📝 TAB CONTENT FUNCTIONS
-- ==========================================
local TabContents = {}

-- 🌾 FARM TAB (ESP Eggs + Auto Steal)
local function CreateFarmTab()
    local FarmTab = Instance.new("Frame")
    FarmTab.Name = "FarmTab"
    FarmTab.Size = UDim2.new(1, 0, 1, 0)
    FarmTab.BackgroundTransparency = 1
    FarmTab.Parent = ContentArea
    
    local SectionLayout = Instance.new("UIListLayout")
    SectionLayout.Padding = UDim.new(0, 15)
    SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SectionLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    SectionLayout.PaddingTop = UDim.new(0, 15)
    SectionLayout.Parent = FarmTab
    
    -- 🥚 ESP Eggs Section
    local ESPSect = Instance.new("Frame")
    ESPSect.Size = UDim2.new(0.95, 0, 0, 240)
    ESPSect.BackgroundColor3 = UI.Gray
    ESPSect.Parent = FarmTab
    Instance.new("UICorner", ESPSect).CornerRadius = UDim.new(0, 10)
    
    local ESPTitle = Instance.new("TextLabel")
    ESPTitle.Size = UDim2.new(1, -20, 0, 35)
    ESPTitle.Position = UDim2.new(0, 10, 0, 5)
    ESPTitle.BackgroundTransparency = 1
    ESPTitle.Text = "🥚 ESP Eggs"
    ESPTitle.Font = Enum.Font.GothamBold
    ESPTitle.TextSize = 18
    ESPTitle.TextColor3 = UI.Text
    ESPTitle.TextXAlignment = Enum.TextXAlignment.Left
    ESPTitle.Parent = ESPSect
    
    -- Toggle: ESP Enabled
    local ESPEnable = CreateToggle(ESPSect, 20, 45, "បើក ESP Eggs", State.ESP_Enabled, function(v)
        State.ESP_Enabled = v
    end)
    
    -- Toggle: Fixed Size
    local ESPFixed = CreateToggle(ESPSect, 20, 85, "ទំហំថេរ", State.ESP_FixedSize, function(v)
        State.ESP_FixedSize = v
    end)
    
    -- Toggle: Show Own Base
    local ESPOwn = CreateToggle(ESPSect, 20, 125, "បង្ហាញពងក្នុងមូលដ្ឋាន", State.ESP_ShowOwnBase, function(v)
        State.ESP_ShowOwnBase = v
    end)
    
    -- Slider: ESP Min Rarity
    local ESPRarity = CreateDropdown(ESPSect, 20, 165, "កម្រិតអប្បបរមា", RarityOrder[State.ESP_MinRarity].Name, {
        "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"
    }, function(v)
        for i, R in ipairs(RarityOrder) do
            if R.Name == v then State.ESP_MinRarity = i end
        end
    end)
    
    -- Slider: ESP Size
    local ESPSize = CreateSlider(ESPSect, 20, 205, "ទំហំសញ្ញា", State.ESP_Size, 0, 100, function(v)
        State.ESP_Size = math.floor(v)
    end)
    
    -- 🥚 Auto Steal Section
    local StealSect = Instance.new("Frame")
    StealSect.Size = UDim2.new(0.95, 0, 0, 280)
    StealSect.BackgroundColor3 = UI.Gray
    StealSect.Parent = FarmTab
    Instance.new("UICorner", StealSect).CornerRadius = UDim.new(0, 10)
    
    local StealTitle = Instance.new("TextLabel")
    StealTitle.Size = UDim2.new(1, -20, 0, 35)
    StealTitle.Position = UDim2.new(0, 10, 0, 5)
    StealTitle.BackgroundTransparency = 1
    StealTitle.Text = "🥚 Auto Steal"
    StealTitle.Font = Enum.Font.GothamBold
    StealTitle.TextSize = 18
    StealTitle.TextColor3 = UI.Text
    StealTitle.TextXAlignment = Enum.TextXAlignment.Left
    StealTitle.Parent = StealSect
    
    -- Toggle: Auto Steal
    local AutoStealToggle = CreateToggle(StealSect, 20, 45, "បើក Auto Steal", State.AutoSteal_Enabled, function(v)
        State.AutoSteal_Enabled = v
    end)
    
    -- Dropdown: Target Areas
    local TargetAreas = CreateDropdown(StealSect, 20, 85, "តំបន់គោលដៅ", "តំបន់ទាំងអស់", {"តំបន់ទាំងអស់", "តំបន់ 1", "តំបន់ 2"}, function(v)
        if v == "តំបន់ទាំងអស់" then State.AutoSteal_TargetAreas = 2
        elseif v == "តំបន់ 1" then State.AutoSteal_TargetAreas = 1
        else State.AutoSteal_TargetAreas = 2 end
    end)
    
    -- Dropdown: Min Rarity
    local StealMinRarity = CreateDropdown(StealSect, 20, 125, "កម្រិតអប្បបរមា", "Any", {"Any", "Common+", "Uncommon+", "Rare+", "Epic+", "Legendary+"}, function(v)
        if v == "Any" then State.AutoSteal_MinRarity = 0
        elseif v == "Common+" then State.AutoSteal_MinRarity = 1
        elseif v == "Uncommon+" then State.AutoSteal_MinRarity = 2
        elseif v == "Rare+" then State.AutoSteal_MinRarity = 3
        elseif v == "Epic+" then State.AutoSteal_MinRarity = 4
        else State.AutoSteal_MinRarity = 5 end
    end)
    
    -- Dropdown: Min Value
    local StealMinValue = CreateDropdown(StealSect, 20, 165, "តម្លៃអប្បបរមា", "1000M/s", {"0M/s", "100M/s", "500M/s", "1000M/s", "5000M/s"}, function(v)
        State.AutoSteal_MinValue = tonumber(string.match(v, "%d+")) or 0
    end)
    
    -- Toggle: Prioritize Rift
    local PrioritizeRift = CreateToggle(StealSect, 20, 205, "អាទិភាព Rift Recipe", State.AutoSteal_PrioritizeRift, function(v)
        State.AutoSteal_PrioritizeRift = v
    end)
    
    -- Slider: Tween Speed
    local TweenSpeedSlider = CreateSlider(StealSect, 20, 245, "ល្បឿនផ្លាស់ទី", State.TweenSpeed, 100, 5000, function(v)
        State.TweenSpeed = math.floor(v)
    end)
    
    TabContents.Farm = FarmTab
    return FarmTab
end

-- 📋 STEAL PANEL (Side Popup)
local StealPanel = Instance.new("Frame")
StealPanel.Name = "StealPanel"
StealPanel.Size = UDim2.new(0, 320, 0, 450)
StealPanel.Position = UDim2.new(1, -340, 0.5, -225)
StealPanel.BackgroundColor3 = UI.BG
StealPanel.BorderSizePixel = 2
StealPanel.BorderColor3 = UI.Primary
StealPanel.Visible = false
StealPanel.Active = true
StealPanel.Draggable = true
StealPanel.Parent = ScreenGui
Instance.new("UICorner", StealPanel).CornerRadius = UDim.new(0, 12)

-- Steal Panel Header
local StealPanelHeader = Instance.new("Frame")
StealPanelHeader.Size = UDim2.new(1, 0, 0, 45)
StealPanelHeader.BackgroundColor3 = UI.Primary
StealPanelHeader.Parent = StealPanel

local StealPanelTitle = Instance.new("TextLabel")
StealPanelTitle.Size = UDim2.new(1, -100, 1, 0)
StealPanelTitle.Position = UDim2.new(0, 10, 0, 0)
StealPanelTitle.BackgroundTransparency = 1
StealPanelTitle.Text = "📋 បញ្ជីពង"
StealPanelTitle.Font = Enum.Font.GothamBold
StealPanelTitle.TextSize = 16
StealPanelTitle.TextColor3 = UI.Text
StealPanelTitle.TextXAlignment = Enum.TextXAlignment.Left
StealPanelTitle.Parent = StealPanelHeader

local SortBtn = Instance.new("TextButton")
SortBtn.Size = UDim2.new(0, 100, 0, 35)
SortBtn.Position = UDim2.new(1, -110, 0, 5)
SortBtn.BackgroundColor3 = UI.Green
SortBtn.Text = "តម្រៀប: តម្លៃ"
SortBtn.Font = Enum.Font.GothamBold
SortBtn.TextSize = 12
SortBtn.TextColor3 = UI.Text
SortBtn.Parent = StealPanelHeader
Instance.new("UICorner", SortBtn).CornerRadius = UDim.new(0, 6)

-- Auto Steal Status
local StealStatus = Instance.new("Frame")
StealStatus.Size = UDim2.new(1, -20, 0, 35)
StealStatus.Position = UDim2.new(0, 10, 0, 55)
StealStatus.BackgroundColor3 = UI.Gray
StealStatus.Parent = StealPanel
Instance.new("UICorner", StealStatus).CornerRadius = UDim.new(0, 6)

local StealStatusText = Instance.new("TextLabel")
StealStatusText.Size = UDim2.new(1, -10, 1, 0)
StealStatusText.Position = UDim2.new(0, 10, 0, 0)
StealStatusText.BackgroundTransparency = 1
StealStatusText.Text = "🔴 Auto Steal: បិទ | ល្បឿន: 1000"
StealStatusText.Font = Enum.Font.GothamBold
StealStatusText.TextSize = 13
StealStatusText.TextColor3 = UI.Text
StealStatusText.TextXAlignment = Enum.TextXAlignment.Left
StealStatusText.Parent = StealStatus

-- Egg List Container
local EggListContainer = Instance.new("ScrollingFrame")
EggListContainer.Size = UDim2.new(1, -20, 1, -110)
EggListContainer.Position = UDim2.new(0, 10, 0, 100)
EggListContainer.BackgroundTransparency = 1
EggListContainer.CanvasSize = UDim2.new(0, 0, 0, #EggList * 50)
EggListContainer.ScrollBarThickness = 6
EggListContainer.Parent = StealPanel

local EggListLayout = Instance.new("UIListLayout")
EggListLayout.Padding = UDim.new(0, 8)
EggListLayout.Parent = EggListContainer

-- Populate Egg List
local function RefreshEggList()
    for _, Child in ipairs(EggListContainer:GetChildren()) do
        if Child:IsA("Frame") then Child:Destroy() end
    end
    
    for _, Egg in ipairs(EggList) do
        local EggItem = Instance.new("Frame")
        EggItem.Size = UDim2.new(1, 0, 0, 45)
        EggItem.BackgroundColor3 = UI.Gray
        EggItem.Parent = EggListContainer
        Instance.new("UICorner", EggItem).CornerRadius = UDim.new(0, 6)
        
        local EggIcon = Instance.new("TextLabel")
        EggIcon.Size = UDim2.new(0, 35, 1, 0)
        EggIcon.Position = UDim2.new(0, 5, 0, 0)
        EggIcon.BackgroundTransparency = 1
        EggIcon.Text = Egg.Icon
        EggIcon.Font = Enum.Font.Gotham
        EggIcon.TextSize = 20
        EggIcon.Parent = EggItem
        
        local EggName = Instance.new("TextLabel")
        EggName.Size = UDim2.new(0, 140, 1, 0)
        EggName.Position = UDim2.new(0, 45, 0, 0)
        EggName.BackgroundTransparency = 1
        EggName.Text = Egg.Name
        EggName.Font = Enum.Font.GothamBold
        EggName.TextSize = 14
        EggName.TextColor3 = RarityOrder[Egg.Rarity].Color
        EggName.TextXAlignment = Enum.TextXAlignment.Left
        EggName.Parent = EggItem
        
        local EggValue = Instance.new("TextLabel")
        EggValue.Size = UDim2.new(0, 80, 1, 0)
        EggValue.Position = UDim2.new(0, 180, 0, 0)
        EggValue.BackgroundTransparency = 1
        EggValue.Text = "$" .. Egg.Value .. Egg.Unit
        EggValue.Font = Enum.Font.Gotham
        EggValue.TextSize = 12
        EggValue.TextColor3 = Color3.fromRGB(120, 255, 120)
        EggValue.TextXAlignment = Enum.TextXAlignment.Right
        EggValue.Parent = EggItem
        
        local StealBtn = Instance.new("TextButton")
        StealBtn.Size = UDim2.new(0, 70, 0, 35)
        StealBtn.Position = UDim2.new(1, -75, 0, 5)
        StealBtn.BackgroundColor3 = UI.Green
        StealBtn.Text = "យក"
        StealBtn.Font = Enum.Font.GothamBold
        StealBtn.TextSize = 13
        StealBtn.TextColor3 = UI.Text
        StealBtn.Parent = EggItem
        Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 6)
        
        StealBtn.MouseButton1Click:Connect(function()
            StealEggByName(Egg.Name)
        end)
    end
end

-- 🧩 HELPER FUNCTIONS: Create Toggle, Dropdown, Slider
function CreateToggle(Parent, X, Y, Label, Default, Callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -40, 0, 35)
    Container.Position = UDim2.new(0, X, 0, Y)
    Container.BackgroundTransparency = 1
    Container.Parent = Parent
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(0.8, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Label
    Text.Font = Enum.Font.Gotham
    Text.TextSize = 14
    Text.TextColor3 = UI.Text
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Container
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 40, 0, 24)
    Toggle.Position = UDim2.new(1, -45, 0.5, -12)
    Toggle.BackgroundColor3 = Default and UI.Green or UI.Red
    Toggle.Text = Default and "ON" or "OFF"
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 11
    Toggle.TextColor3 = UI.Text
    Toggle.Parent = Container
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)
    
    Toggle.MouseButton1Click:Connect(function()
        Default = not Default
        Toggle.BackgroundColor3 = Default and UI.Green or UI.Red
        Toggle.Text = Default and "ON" or "OFF"
        Callback(Default)
    end)
    
    return Container
end

function CreateDropdown(Parent, X, Y, Label, Default, Options, Callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -40, 0, 35)
    Container.Position = UDim2.new(0, X, 0, Y)
    Container.BackgroundTransparency = 1
    Container.Parent = Parent
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(0.5, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Label
    Text.Font = Enum.Font.Gotham
    Text.TextSize = 14
    Text.TextColor3 = UI.Text
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Container
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0.45, 0, 0, 30)
    DropBtn.Position = UDim2.new(0.55, 0, 0.5, -15)
    DropBtn.BackgroundColor3 = UI.Darker
    DropBtn.Text = Default
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.TextSize = 11
    DropBtn.TextColor3 = UI.Text
    DropBtn.Parent = Container
    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 6)
    
    local Open = false
    DropBtn.MouseButton1Click:Connect(function()
        Open = not Open
        if Open then
            ShowDropdownList(DropBtn, Options, function(Choice)
                DropBtn.Text = Choice
                Callback(Choice)
                Open = false
            end)
        end
    end)
    
    return Container
end

function CreateSlider(Parent, X, Y, Label, Default, Min, Max, Callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -40, 0, 45)
    Container.Position = UDim2.new(0, X, 0, Y)
    Container.BackgroundTransparency = 1
    Container.Parent = Parent
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, 0, 0, 20)
    Text.BackgroundTransparency = 1
    Text.Text = Label .. ": " .. Default
    Text.Font = Enum.Font.Gotham
    Text.TextSize = 14
    Text.TextColor3 = UI.Text
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Container
    
    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, 0, 0, 12)
    BarBg.Position = UDim2.new(0, 0, 0, 28)
    BarBg.BackgroundColor3 = UI.Darker
    BarBg.Parent = Container
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 6)
    
    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
    BarFill.BackgroundColor3 = UI.Primary
    BarFill.Parent = BarBg
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 6)
    
    return Container
end

function ShowDropdownList(Parent, Options, Callback)
    local List = Instance.new("Frame")
    List.Size = UDim2.new(Parent.Size.Width.Scale, Parent.Size.Width.Offset, 0, #Options * 30)
    List.Position = UDim2.new(Parent.Position.X.Scale, Parent.Position.X.Offset, 1, 5)
    List.BackgroundColor3 = UI.Darker
    List.ZIndex = 100
    List.Parent = Parent.Parent
    Instance.new("UICorner", List).CornerRadius = UDim.new(0, 6)
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 2)
    Layout.Parent = List
    
    for _, Opt in ipairs(Options) do
        local Item = Instance.new("TextButton")
        Item.Size = UDim2.new(1, -4, 0, 28)
        Item.BackgroundColor3 = UI.Gray
        Item.Text = Opt
        Item.Font = Enum.Font.Gotham
        Item.TextSize = 11
        Item.TextColor3 = UI.Text
        Item.Parent = List
        Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 4)
        
        Item.MouseButton1Click:Connect(function()
            Callback(Opt)
            List:Destroy()
        end)
    end
    
    delay(3, function() if List then List:Destroy() end end)
end

-- ==========================================
-- 🔄 TAB MANAGEMENT
-- ==========================================
function ShowTabContent(TabName)
    for _, Child in ipairs(ContentArea:GetChildren()) do
        if Child:IsA("Frame") then Child:Destroy() end
    end
    
    if TabName == "Farm" then
        CreateFarmTab()
    else
        local Placeholder = Instance.new("TextLabel")
        Placeholder.Size = UDim2.new(1, 0, 1, 0)
        Placeholder.BackgroundTransparency = 1
        Placeholder.Text = "📁 " .. TabName .. "\n\nមិនទាន់មានមុខងារនៅឡើយ\n\nសូមរង់ចាំអាប់ដេតបន្ទាប់!"
        Placeholder.Font = Enum.Font.GothamBold
        Placeholder.TextSize = 24
        Placeholder.TextColor3 = UI.Text
        Placeholder.TextWrapped = true
        Placeholder.Parent = ContentArea
    end
end

-- ==========================================
-- 🥚 STEAL FUNCTION
-- ==========================================
function StealEggByName(EggName)
    local Now = os.clock()
    if Now - State.LastStealTime < State.StealCooldown then return end
    State.LastStealTime = Now
    
    print("🥚 កំពុងយកពង: " .. EggName)
    SendNotification("ជោគជ័យ", "បានយកពង: " .. EggName, 3)
end

-- ==========================================
-- 🔔 NOTIFICATION
-- ==========================================
function SendNotification(Title, Msg, Dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = Title,
            Text = Msg,
            Duration = Dur or 3
        })
    end)
end

-- ==========================================
-- 🎯 MAIN TOGGLE: Open/Close Hub
-- ==========================================
FloatingBtn.MouseButton1Click:Connect(function()
    State.HubOpen = not State.HubOpen
    MainWindow.Visible = State.HubOpen
    if State.HubOpen then
        ShowTabContent("Farm")
        TabButtons["Farm"].BackgroundColor3 = UI.Primary
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    State.HubOpen = false
    MainWindow.Visible = false
end)

-- 📋 Toggle Steal Panel
local ShowStealPanel = Instance.new("TextButton")
ShowStealPanel.Size = UDim2.new(0, 45, 0, 45)
ShowStealPanel.Position = UDim2.new(1, -105, 1, -75)
ShowStealPanel.BackgroundColor3 = UI.Button
ShowStealPanel.Text = "📋"
ShowStealPanel.Font = Enum.Font.GothamBold
ShowStealPanel.TextSize = 20
ShowStealPanel.TextColor3 = UI.Text
ShowStealPanel.Active = true
ShowStealPanel.Draggable = true
ShowStealPanel.Parent = ScreenGui
Instance.new("UICorner", ShowStealPanel).CornerRadius = UDim.new(0, 10)

ShowStealPanel.MouseButton1Click:Connect(function()
    StealPanel.Visible = not StealPanel.Visible
    if StealPanel.Visible then
        RefreshEggList()
    end
end)

-- 🚀 INITIALIZE
task.spawn(function()
    task.wait(1)
    RefreshEggList()
    print("✅ JINGHOK HUB ដំណើរការបានជោគជ័យ!")
    print("👉 ចុចប៊ូតុង JH ពណ៌ផ្កាឈូក នៅជ្រុងក្រោមស្តាំ ដើម្បីបើកម៉ឺនុយ")
    SendNotification("JINGHOK HUB", "បើកដំណើរការដោយជោគជ័យ! ✅", 4)
end)
