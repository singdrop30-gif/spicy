local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI_Theme = {
    MainBG = Color3.fromRGB(20, 15, 25),
    Accent = Color3.fromRGB(255, 0, 127),
    Green = Color3.fromRGB(50, 200, 50),
    Red = Color3.fromRGB(200, 50, 50),
    Text = Color3.new(1, 1, 1)
}

local State = {Speed = false, Jump = false, Ragdoll = false}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HokHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 320)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -160)
MainFrame.BackgroundColor3 = UI_Theme.MainBG
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = UI_Theme.Accent
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = UI_Theme.Accent
Title.Text = "🔥 មជ្ឈមណ្ឌល HOK"
Title.TextColor3 = UI_Theme.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = MainFrame

local function Button(Name, Text, Y)
    local B = Instance.new("TextButton")
    B.Name = Name
    B.Size = UDim2.new(0, 260, 0, 45)
    B.Position = UDim2.new(0, 20, 0, Y)
    B.BackgroundColor3 = UI_Theme.Red
    B.Text = Text
    B.TextColor3 = UI_Theme.Text
    B.Font = Enum.Font.GothamBold
    B.TextSize = 14
    B.Parent = MainFrame
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    B.MouseButton1Click:Connect(function()
        State[Name] = not State[Name]
        B.BackgroundColor3 = State[Name] and UI_Theme.Green or UI_Theme.Red
    end)
    return B
end

Button("Speed", "⚡ រត់លឿន", 70)
Button("Jump", "🦘 លោតគ្មានដែនកំណត់", 130)
Button("Ragdoll", "💪 ការពារកុំឱ្យដួល", 190)

UIS.JumpRequest:Connect(function()
    if State.Jump then task.wait()
        local Char = Player.Character
        if Char and Char:FindFirstChild("Humanoid") then
            Char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RS.Heartbeat:Connect(function()
    if State.Speed then
        local Char = Player.Character
        if Char and Char:FindFirstChild("Humanoid") then
            Char.Humanoid.WalkSpeed = 600
        end
    end
end)

print("✅ 🔥 HOK HUB — បានផ្ទុក!")
