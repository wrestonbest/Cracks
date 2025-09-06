local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ControlTable = {HideMethod = false}

local function GetBodyClass(Name)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA(Name, true) then
        return LocalPlayer.Character:FindFirstChildWhichIsA(Name, true)
    end
    return nil
end

local function GetBodyChild(Name)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(Name, true) then
        return LocalPlayer.Character:FindFirstChild(Name, true)
    end
    return nil
end

local function SafeDestroy(TargetDelete)
    Debris:AddItem(TargetDelete, 0)
end

local function SafeReplicateSignal(Signal, ...)
    if replicatesignal then
        replicatesignal(Signal, ...)
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JackBypassGui"
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 120, 0, 80)  -- Smaller size
Frame.Position = UDim2.new(0.5, -60, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  -- Slightly lighter black
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Red Outline
local Outline = Instance.new("UIStroke")
Outline.Color = Color3.fromRGB(255, 0, 0)  -- Red outline
Outline.Thickness = 2
Outline.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1  -- Transparent background
Title.Text = "discord: wrestonmain"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Parent = Frame

-- Button
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8, 0, 0, 25)
Button.Position = UDim2.new(0.1, 0, 0, 30)
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Lighter black than frame
Button.Text = "invisible"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 12
Button.AutoButtonColor = false
Button.Parent = Frame

-- Button Outline
local ButtonOutline = Instance.new("UIStroke")
ButtonOutline.Color = Color3.fromRGB(255, 0, 0)  -- Red outline
ButtonOutline.Thickness = 1
ButtonOutline.Parent = Button

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 4)
BtnCorner.Parent = Button

-- Instruction Text
local Instruction = Instance.new("TextLabel")
Instruction.Size = UDim2.new(1, 0, 0, 15)
Instruction.Position = UDim2.new(0, 0, 0, 60)
Instruction.BackgroundTransparency = 1
Instruction.Text = "click invisible when steal"
Instruction.Font = Enum.Font.Gotham
Instruction.TextColor3 = Color3.fromRGB(200, 200, 200)
Instruction.TextSize = 10
Instruction.Parent = Frame

-- Hover effect
Button.MouseEnter:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(80, 0, 180)
end)
Button.MouseLeave:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

--// Draggable
local dragging, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// Persistent ESP
local espBox
local function EnableESP()
    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and not espBox then
        espBox = Instance.new("BoxHandleAdornment")
        espBox.Adornee = hrp
        espBox.Size = hrp.Size
        espBox.Color3 = Color3.fromRGB(255, 0, 0)
        espBox.Transparency = 0.4
        espBox.ZIndex = 10
        espBox.AlwaysOnTop = true
        espBox.Parent = hrp
    end
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        espBox = nil
        EnableESP()
    end)
end

--// Button Function
Button.MouseButton1Click:Connect(function()
    EnableESP()
    ControlTable.HideMethod = true

    local humanoid = GetBodyClass("Humanoid")
    local LastCFrame = GetBodyChild("HumanoidRootPart") and GetBodyChild("HumanoidRootPart").CFrame or nil
    if humanoid then humanoid.HipHeight = 0.01 end

    if LocalPlayer.Character and humanoid then
        SafeReplicateSignal(humanoid.ServerBreakJoints)
        for _, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                SafeDestroy(v)
            end
        end
    end

    task.wait(0.1)
    if humanoid then humanoid.HipHeight = 0.01 end
    if LastCFrame then GetBodyChild("HumanoidRootPart").CFrame = LastCFrame end
    ControlTable.HideMethod = false

    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 0.01
        end
    end

    task.spawn(function()
        local hrp = GetBodyChild("HumanoidRootPart")
        while hrp and LocalPlayer.Character do
            hrp.CFrame = LocalPlayer.Character:GetPivot()
            task.wait(0.03)
        end
    end)
end)
