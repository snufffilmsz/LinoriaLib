local Library = {
    Registry = {},
    RegistryMap = {},
    HudRegistry = {},

    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(28, 28, 28),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    AccentColor = Color3.fromRGB(0, 85, 255),
    OutlineColor = Color3.fromRGB(50, 50, 50),
    Black = Color3.new(0, 0, 0),
    Font = Enum.Font.Code,
}

function Library:CreateLoader()
    local Outer = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(300, 140),
        Visible = true,
        ZIndex = 1,
        Parent = ScreenGui
    })

    Library:MakeDraggable(Outer, 25)

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.AccentColor,
        BorderMode = Enum.BorderMode.Inset,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        ZIndex = 1,
        Parent = Outer
    })

    Library:AddToRegistry(Inner, {
        BackgroundColor3 = 'MainColor',
        BorderColor3 = 'AccentColor'
    })

    local LoaderLabel = Library:CreateLabel({
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 25),
        Text = 'Loader',
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 1,
        Parent = Inner
    })

    local MainSection = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor,
        BorderColor3 = Library.OutlineColor,
        Position = UDim2.new(0, 8, 0, 25),
        Size = UDim2.new(1, -16, 1, -33),
        ZIndex = 1,
        Parent = Inner
    })

    Library:AddToRegistry(MainSection, {
        BackgroundColor3 = 'BackgroundColor',
        BorderColor3 = 'OutlineColor'
    })

    local LoadButton = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,
        Position = UDim2.new(0.1, 0, 0.5, -15),
        Size = UDim2.new(0.35, 0, 0, 30),
        AutoButtonColor = false,
        Text = "Load",
        Font = Library.Font,
        TextColor3 = Library.FontColor,
        TextSize = 14,
        ZIndex = 2,
        Parent = MainSection
    })

    local ExitButton = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,
        Position = UDim2.new(0.55, 0, 0.5, -15),
        Size = UDim2.new(0.35, 0, 0, 30),
        AutoButtonColor = false,
        Text = "Exit",
        Font = Library.Font,
        TextColor3 = Library.FontColor,
        TextSize = 14,
        ZIndex = 2,
        Parent = MainSection
    })

    Library:AddToRegistry(LoadButton, {
        BackgroundColor3 = 'MainColor',
        BorderColor3 = 'OutlineColor',
        TextColor3 = 'FontColor'
    })

    Library:AddToRegistry(ExitButton, {
        BackgroundColor3 = 'MainColor',
        BorderColor3 = 'OutlineColor',
        TextColor3 = 'FontColor'
    })

    Library:OnHighlight(LoadButton, LoadButton,
        { BorderColor3 = 'AccentColor' },
        { BorderColor3 = 'OutlineColor' }
    )

    Library:OnHighlight(ExitButton, ExitButton,
        { BorderColor3 = 'AccentColor' },
        { BorderColor3 = 'OutlineColor' }
    )

    LoadButton.MouseButton1Click:Connect(function()
        LoadButton.Text = "Loading..."
        task.wait(0.5)
        Outer:Destroy()
        Library:Initialize()
    end)

    ExitButton.MouseButton1Click:Connect(function()
        Outer:Destroy()
    end)
end

return Library
