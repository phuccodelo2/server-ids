--// Float with UI (bo cong + draggable)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FloatUI"

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0,120,0,40)
ToggleButton.Position = UDim2.new(0,10,0,10) -- mặc định góc trái trên
ToggleButton.Text = "Airwalk: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.BorderSizePixel = 2

-- Bo cong góc
local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(0,10)

-- Cho phép kéo UI
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    ToggleButton.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
       or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Platform
local platform
local running = false
local loop

-- Start float
local function startFloat()
    if running then return end
    running = true
    ToggleButton.Text = "Airwalk: ON"

    platform = Instance.new("Part")
    platform.Size = Vector3.new(6, 1, 6)
    platform.Anchored = true
    platform.Color = Color3.fromRGB(150,150,255)
    platform.Material = Enum.Material.SmoothPlastic
    platform.Name = "FloatPlatform"
    platform.Transparency = 0.2
    platform.CanCollide = true
    platform.Parent = workspace

    loop = game:GetService("RunService").Heartbeat:Connect(function()
        if hrp and hrp.Parent then
            platform.CFrame = hrp.CFrame * CFrame.new(0,-4.7,0)
        end
    end)
end

-- Stop float
local function stopFloat()
    running = false
    ToggleButton.Text = "Airwalk: OFF"
    if loop then loop:Disconnect() end
    if platform then platform:Destroy() end
end

-- Toggle
ToggleButton.MouseButton1Click:Connect(function()
    if running then
        stopFloat()
    else
        startFloat()
    end
end)