local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local Tween = game:GetService("TweenService")
local Player = Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")

local UI = {BG=Color3.fromRGB(30,30,45), Accent=Color3.fromRGB(255,0,140), Green=Color3.fromRGB(40,180,40), Gray=Color3.fromRGB(60,60,80), Text=Color3.new(1,1,1)}
local State = {Open=false, AutoSteal=false, Speed=1000, IsMoving=false}
local Creatures = {
    {Name="Winged Lamb", Val=1.3, Unit="M/s", Col=Color3.fromRGB(255,230,150)},
    {Name="Bladehide", Val=753.7, Unit="K/s", Col=Color3.fromRGB(80,160,220)},
    {Name="Cosmic Gecko", Val=720.8, Unit="K/s", Col=Color3.fromRGB(100,80,220)},
    {Name="Light Dove", Val=557.3, Unit="K/s", Col=Color3.fromRGB(240,240,255)},
    {Name="Cosmic Gorilla", Val=379.0, Unit="K/s", Col=Color3.fromRGB(70,90,140)},
    {Name="Pure Jellyfish", Val=950.0, Unit="K/s", Col=Color3.fromRGB(200,100,255)}
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JinghokHub"
ScreenGui.Parent = Gui

-- 💖 ប៊ូតុងនៅកណ្តាល
local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0,70,0,70)
Btn.Position = UDim2.new(0.5,-35,0.6,-35)
Btn.BackgroundColor3 = UI.Accent
Btn.Text = "💖"
Btn.TextColor3 = UI.Text
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 30
Btn.Parent = ScreenGui
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,16)

-- 📋 Panel
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0,420,0,520)
Panel.Position = UDim2.new(0.5,-210,0.5,-260)
Panel.BackgroundColor3 = UI.BG
Panel.BorderSizePixel = 3
Panel.BorderColor3 = UI.Accent
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = ScreenGui
Instance.new("UICorner",Panel).CornerRadius = UDim.new(0,12)

-- ក្បាល
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,50)
Header.BackgroundColor3 = UI.Accent
Header.Parent = Panel
Instance.new("UICorner",Header).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "💖 Jinghok Hub"
Title.TextColor3 = UI.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Header

-- Auto + Speed
local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0.45,0,0,45)
AutoBtn.Position = UDim2.new(0.05,0,0.13,0)
AutoBtn.BackgroundColor3 = UI.Green
AutoBtn.Text = "🥚 Auto Steal: ON"
AutoBtn.TextColor3 = UI.Text
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.TextSize = 14
AutoBtn.Parent = Panel
Instance.new("UICorner",AutoBtn).CornerRadius = UDim.new(0,8)

local SpeedLbl = Instance.new("TextLabel")
SpeedLbl.Size = UDim2.new(0.45,0,0,45)
SpeedLbl.Position = UDim2.new(0.50,0,0.13,0)
SpeedLbl.BackgroundColor3 = UI.Gray
SpeedLbl.Text = "⚡ កម្លាំងរត់: 1000"
SpeedLbl.TextColor3 = UI.Text
SpeedLbl.Font = Enum.Font.GothamBold
SpeedLbl.TextSize = 14
SpeedLbl.Parent = Panel
Instance.new("UICorner",SpeedLbl).CornerRadius = UDim.new(0,8)

-- Slider
local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(0.90,0,0,14)
SliderBg.Position = UDim2.new(0.05,0,0.24,0)
SliderBg.BackgroundColor3 = UI.Gray
SliderBg.Parent = Panel
Instance.new("UICorner",SliderBg).CornerRadius = UDim.new(0,7)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(1,0,1,0)
SliderFill.BackgroundColor3 = UI.Accent
SliderFill.Parent = SliderBg
Instance.new("UICorner",SliderFill).CornerRadius = UDim.new(0,7)

-- បញ្ជី
local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(0.90,0,0.60,0)
List.Position = UDim2.new(0.05,0,0.35,0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 6
List.Parent = Panel

local function FlyTo(Target)
    if not Target or State.IsMoving then return end
    local Char = Player.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    State.IsMoving = true
    local Root = Char.HumanoidRootPart
    local EndPos = Target.Position + Vector3.new(0,3,0)
    local Dist = (EndPos - Root.Position).Magnitude
    local Dur = math.max(0.15, Dist / State.Speed)
    Tween:Create(Root, TweenInfo.new(Dur), {CFrame=CFrame.new(EndPos)}):Play()
    task.wait(Dur)
    State.IsMoving = false
end

local function Refresh()
    List:ClearAllChildren()
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,6)
    Layout.Parent = List
    for _, C in ipairs(Creatures) do
        local Item = Instance.new("Frame")
        Item.Size = UDim2.new(1,0,0,55)
        Item.BackgroundColor3 = UI.Gray
        Item.Parent = List
        Instance.new("UICorner",Item).CornerRadius = UDim.new(0,8)
        
        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(0.55,0,1,0)
        Name.Position = UDim2.new(0.03,0,0,0)
        Name.BackgroundTransparency = 1
        Name.Text = C.Name.."  $"..C.Val..C.Unit
        Name.TextColor3 = C.Col
        Name.Font = Enum.Font.GothamBold
        Name.TextSize = 13
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.Parent = Item
        
        local Go = Instance.new("TextButton")
        Go.Size = UDim2.new(0.35,0,0,45)
        Go.Position = UDim2.new(0.62,0,0.08,0)
        Go.BackgroundColor3 = UI.Green
        Go.Text = "✅ រើស"
        Go.TextColor3 = UI.Text
        Go.Font = Enum.Font.GothamBold
        Go.TextSize = 14
        Go.Parent = Item
        Instance.new("UICorner",Go).CornerRadius = UDim.new(0,8)
        
        Go.MouseButton1Click:Connect(function()
            local Found = nil
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("BasePart") and string.find(string.lower(v.Name), string.lower(C.Name)) then
                    Found = v; break
                end
            end
            if Found then FlyTo(Found); Go.Text = "✅ ទៅហើយ!"; task.delay(1.5,function()Go.Text="✅ រើស"end)
            else Go.Text = "❌ រកមិនឃើញ"; task.delay(1.5,function()Go.Text="✅ រើស"end) end
        end)
    end
end

-- 🖱️ ចុចប៊ូតុងកណ្តាល → បើក/បិទ Panel
Btn.MouseButton1Click:Connect(function()
    State.Open = not State.Open
    Panel.Visible = State.Open
    if State.Open then Refresh() end
end)

AutoBtn.MouseButton1Click:Connect(function()
    State.AutoSteal = not State.AutoSteal
    AutoBtn.BackgroundColor3 = State.AutoSteal and UI.Green or UI.Gray
    AutoBtn.Text = State.AutoSteal and "🥚 Auto Steal: ON" or "🥚 Auto Steal: OFF"
end)

SliderBg.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        local Pos = math.clamp((UIS:GetMouseLocation().X - SliderBg.AbsolutePosition.X)/SliderBg.AbsoluteSize.X,0,1)
        State.Speed = Pos<0.33 and 100 or Pos<0.66 and 500 or 1000
        SpeedLbl.Text = "⚡ កម្លាំងរត់: "..State.Speed
        SliderFill.Size = UDim2.new(Pos,0,1,0)
    end
end)

print("💖 Jinghok Hub — រួចរាល់!")
print("💖 ចុចប៊ូតុង 💖 នៅកណ្តាលអេក្រង់!")
