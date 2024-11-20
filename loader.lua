local InputService = game:GetService('UserInputService')
local CoreGui = game:GetService('CoreGui')
local TweenService = game:GetService('TweenService')

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = CoreGui

local Library = {
    MainColor = Color3.fromRGB(28, 28, 28),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    AccentColor = Color3.fromRGB(0, 85, 255),
    OutlineColor = Color3.fromRGB(50, 50, 50),
    FontColor = Color3.new(1, 1, 1),
    Black = Color3.new(0, 0, 0),
    Font = Enum.Font.Code
}

local Loader = {}

function Library:Create(Class, Properties)
    local Object = Instance.new(Class)
    
    for Property, Value in next, Properties do
        Object[Property] = Value
    end
    
    return Object
end

function Library:CreateLoader()
    local Main = Library:Create('Frame', {
        Size = UDim2.new(0, 300, 0, 150),
        Position = UDim2.new(0.5, -150, 0.5, -75),
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,
        Parent = ScreenGui
    })

    local Title = Library:Create('TextLabel', {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = "periphean.wtf",
        TextColor3 = Library.FontColor,
        TextSize = 16,
        Font = Library.Font,
        Parent = Main
    })

    local Container = Library:Create('Frame', {
        Position = UDim2.new(0, 10, 0, 40),
        Size = UDim2.new(1, -20, 1, -50),
        BackgroundColor3 = Library.BackgroundColor,
        BorderColor3 = Library.OutlineColor,
        Parent = Main
    })

    local LoadButton = Library:Create('TextButton', {
        Position = UDim2.new(0.1, 0, 0.5, -15),
        Size = UDim2.new(0.35, 0, 0, 30),
        BackgroundColor3 = Library.AccentColor,
        BorderColor3 = Library.Black,
        Text = "Load",
        TextColor3 = Library.FontColor,
        TextSize = 14,
        Font = Library.Font,
        Parent = Container
    })

    local ExitButton = Library:Create('TextButton', {
        Position = UDim2.new(0.55, 0, 0.5, -15),
        Size = UDim2.new(0.35, 0, 0, 30),
        BackgroundColor3 = Library.AccentColor,
        BorderColor3 = Library.Black,
        Text = "Exit",
        TextColor3 = Library.FontColor,
        TextSize = 14,
        Font = Library.Font,
        Parent = Container
    })

    LoadButton.MouseButton1Click:Connect(function()
        LoadButton.Text = "Loading..."
        task.wait(0.5)

        local Tween = TweenService:Create(Main, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, -150, 1.5, -75)
        })
        Tween:Play()
        Tween.Completed:Wait()

        ScreenGui:Destroy()
        Library:Initialize()
    end)

    ExitButton.MouseButton1Click:Connect(function()
        local Tween = TweenService:Create(Main, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, -150, 1.5, -75)
        })
        Tween:Play()
        Tween.Completed:Wait()
        ScreenGui:Destroy()
    end)

    local Dragging = false
    local DragStart = nil
    local StartPos = nil

    Title.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPos = Main.Position
        end
    end)

    InputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
            local Delta = Input.Position - DragStart
            Main.Position = UDim2.new(
                StartPos.X.Scale,
                StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale,
                StartPos.Y.Offset + Delta.Y
            )
        end
    end)

    InputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)
end

return Library
