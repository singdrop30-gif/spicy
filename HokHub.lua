local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI_Theme = {
    MainBG = Color3.fromRGB(20, 15, 25),
    Accent = Color3.fromRGB(255, 0, 127),
    Secondary = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    Green = Color3.fromRGB(50, 200, 50),
    Red = Color3.fromRGB(200, 50, 50)
}

local State = {
    AutoSteal = false,
    SpeedBoost = false,
    InfiniteJump = false,
    AntiRagdoll = false,
    EggESP = true,
    BoostSpeed = 580,
    OriginalSpeed = 16,
    ESPObjects = {}
}

local EggData = {
    ["Egg"] = {Value = 1, Rarity = "ធម្មតា", Color = Color3.fromRGB(200,200,200)},
    ["Wooden Egg"] = {Value = 5, Rarity = "ធម្មតា", Color = Color3.fromRGB(139,90,43)},
    ["Blue Egg"] = {Value = 25, Rarity = "កម្រមាន", Color = Color3.fromRGB(50,150,255)},
    ["Green Egg"] = {Value = 50, Rarity = "កម្រមាន", Color = Color3.fromRGB(50,200,50)},
    ["Golden Egg"] = {Value = 500, Rarity = "កម្រ", Color = Color3.fromRGB(255,215,0)},
    ["Diamond Egg"] = {Value = 2500, Rarity = "កម្រ", Color = Color3.fromRGB(100,220,255)},
    ["Rainbow Egg"] = {Value = 15000, Rarity = "ខ្ពស់", Color = Color3.fromRGB(255,100,255)},
    ["Galaxy Egg"] = {Value = 75000, Rarity = "ខ្ពស់", Color = Color3.fromRGB(100,50,255)},
    ["Unknown"] = {Value = 0, Rarity = "មិនស្គាល់", Color = Color3.fromRGB(150,150,150)}
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HokHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,320,0,520)
MainFrame.Position = UDim2.new(0.02,0,0.5,-260)
MainFrame.BackgroundColor3 = UI_Theme.MainBG
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = UI_Theme.Accent
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,50)
TitleBar.BackgroundColor3 = UI_Theme.Accent
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1,0,1,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 មជ្ឈមណ្ឌល HOK"
TitleLabel.TextColor3 = UI_Theme.Text
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 22
TitleLabel.Parent = TitleBar

local function បង្កើតប៊ូតុង(Parent,Name,អត្ថបទ,Pos,Callback)
    local B=Instance.new("TextButton")
    B.Name=Name
    B.Size=UDim2.new(0,280,0,40)
    B.Position=Pos
    B.BackgroundColor3=UI_Theme.Red
    B.Text=អត្ថបទ
    B.TextColor3=UI_Theme.Text
    B.Font=Enum.Font.GothamBold
    B.TextSize=12
    B.Parent=Parent
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,8)
    B.MouseButton1Click:Connect(function()
        Callback()
        State[Name]=not State[Name]
        B.BackgroundColor3=State[Name] and UI_Theme.Green or UI_Theme.Red
    end)
    return B
end

local function ស្លាក(អត្ថបទ,Y)
    local L=Instance.new("TextLabel")
    L.Size=UDim2.new(1,-20,0,25)
    L.Position=UDim2.new(0,10,0,Y)
    L.BackgroundTransparency=1
    L.Text=អត្ថបទ
    L.TextColor3=UI_Theme.Accent
    L.Font=Enum.Font.GothamBold
    L.TextSize=14
    L.TextXAlignment=Enum.TextXAlignment.Left
    L.Parent=MainFrame
end

ស្លាក("🥚 មើលស៊ុតទាំងអស់",60)
បង្កើតប៊ូតុង(MainFrame,"EggESP","👁️ បើកមើលស៊ុត",UDim2.new(0,20,0,90),function()State.EggESP=not State.EggESP end)

ស្លាក("🏃 ចលនា",140)
បង្កើតប៊ូតុង(MainFrame,"SpeedBoost","⚡ បង្កើនល្បឿនរត់",UDim2.new(0,20,0,170),function()
    State.SpeedBoost=not State.SpeedBoost
    local C=Player.Character
    if C and C:FindFirstChild("Humanoid") then
        C.Humanoid.WalkSpeed=State.SpeedBoost and State.BoostSpeed or State.OriginalSpeed
    end
end)

បង្កើតប៊ូតុង(MainFrame,"InfiniteJump","🦘 លោតគ្មានដែនកំណត់",UDim2.new(0,20,0,230),function()State.InfiniteJump=not State.InfiniteJump end)

ស្លាក("🛡️ ការពារ",290)
បង្កើតប៊ូតុង(MainFrame,"AntiRagdoll","💪 ការពារកុំឱ្យដួល",UDim2.new(0,20,0,320),function()State.AntiRagdoll=not State.AntiRagdoll end)

UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then task.wait()
        local C=Player.Character
        if C and C:FindFirstChild("Humanoid") then
            C.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if State.SpeedBoost then
        local C=Player.Character
        if C and C:FindFirstChild("Humanoid") then C.Humanoid.WalkSpeed=State.BoostSpeed end
    end
end)

print("✅ 🔥 HOK HUB — បានផ្ទុក!")
