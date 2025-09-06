local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local SPEED = 40
local JUMP_POWER = 70
local running = false
local renderConnection
local function applyVelocity(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.JumpPower = JUMP_POWER
    humanoid.UseJumpPower = true
    
    renderConnection = RunService.RenderStepped:Connect(function()
        if running and humanoid and humanoid.RootPart then
            local direction = humanoid.MoveDirection
            if direction.Magnitude > 0 then
                humanoid.RootPart.Velocity = Vector3.new(
                    direction.X * SPEED,
                    humanoid.RootPart.Velocity.Y, 
                    direction.Z * SPEED
                )
            end
        end
    end)
end

local function startSpeed()
    if running then return end
    running = true
    if player.Character then
        applyVelocity(player.Character)
    end
end

local function stopSpeed()
    running = false
    if renderConnection then 
        renderConnection:Disconnect() 
        renderConnection = nil 
    end
end

player.CharacterAdded:Connect(function(char)
    if running then
        char:WaitForChild("Humanoid")
        applyVelocity(char)
    end
end)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedToggleGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Position = UDim2.new(1, -215, 0, 60)
toggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
toggleButton.BorderColor3 = Color3.fromRGB(0,0,0)
toggleButton.BorderSizePixel = 2
toggleButton.Text = "Speed"
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = ScreenGui
toggleButton.Active = true
toggleButton.Draggable = true

local toggled = false
toggleButton.MouseButton1Click:Connect(function()
    toggled = not toggled
    toggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0,200,0) or Color3.fromRGB(255,0,0)
    if toggled then 
        startSpeed() 
    else 
        stopSpeed() 
    end
end)
