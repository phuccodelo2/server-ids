--// PHUCMAX Rainbow Hub
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "PHUCMAX_UI"

-- Toggle Button (nút mở/đóng UI chính)
local ToggleMain = Instance.new("ImageButton", ScreenGui)
ToggleMain.Size = UDim2.new(0,50,0,50)
ToggleMain.Position = UDim2.new(0,20,0.5,-25)
ToggleMain.Image = "rbxassetid://1125510" -- ID hình (đổi tuỳ mày)
ToggleMain.BackgroundTransparency = 1

-- Kéo thả Toggle Button
local dragging, dragInput, dragStart, startPos
local function dragify(frame)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
dragify(ToggleMain)

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,300,0,400)
MainFrame.Position = UDim2.new(0.5,-150,0.5,-200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Visible = false

-- Bo góc
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0,12)

-- Viền rainbow
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Rainbow effect cho viền
task.spawn(function()
    while task.wait() do
        for i = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(i,1,1)
            task.wait(0.05)
        end
    end
end)

-- Title PHUCMAX rainbow
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "PHUCMAX"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundTransparency = 1

task.spawn(function()
    while task.wait() do
        for i = 0,1,0.01 do
            Title.TextColor3 = Color3.fromHSV(i,1,1)
            task.wait(0.05)
        end
    end
end)

-- Scrollable buttons
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1,0,1,-40)
ScrollingFrame.Position = UDim2.new(0,0,0,40)
ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.BackgroundTransparency = 1

-- Demo button 1 (Run Script)
local Btn1 = Instance.new("TextButton", ScrollingFrame)
Btn1.Size = UDim2.new(1,-20,0,40)
Btn1.Position = UDim2.new(0,10,0,10)
Btn1.Text = "Run Demo Script"
Btn1.BackgroundColor3 = Color3.fromRGB(40,40,40)
Btn1.TextColor3 = Color3.fromRGB(255,255,255)
local UICorner1 = Instance.new("UICorner", Btn1)
UICorner1.CornerRadius = UDim.new(0,8)

Btn1.MouseButton1Click:Connect(function()
    print("Demo script chạy!")
    -- chèn script thật ở đây
end)

-- Demo button 2 (Toggle Feature)
local Btn2 = Instance.new("TextButton", ScrollingFrame)
Btn2.Size = UDim2.new(1,-20,0,40)
Btn2.Position = UDim2.new(0,10,0,60)
Btn2.Text = "Feature: OFF"
Btn2.BackgroundColor3 = Color3.fromRGB(40,40,40)
Btn2.TextColor3 = Color3.fromRGB(255,255,255)
local UICorner2 = Instance.new("UICorner", Btn2)
UICorner2.CornerRadius = UDim.new(0,8)

local featureOn = false
Btn2.MouseButton1Click:Connect(function()
    featureOn = not featureOn
    Btn2.Text = featureOn and "Feature: ON" or "Feature: OFF"
end)

-- Kéo thả main UI
dragify(MainFrame)

-- Toggle UI chính bằng nút hình
ToggleMain.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
