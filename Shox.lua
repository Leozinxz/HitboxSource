-- [ Carregamento ]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
--[ Sistema Principal ]

local ScreenGui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local label = Instance.new("TextLabel")
local HitboxButton, CloseButton, MinimizeButton, MaximizeButton
local HitboxSizeSlider = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")
local SliderLabel = Instance.new("TextLabel")
 
ScreenGui.Parent = game.CoreGui
 
-- [ Configuração UI Principal ]

main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
main.Position = UDim2.new(0.35, 0, 0.32, 0)
main.Size = UDim2.new(0, 400, 0, 250)
main.Active = true
main.Draggable = true
main.BorderSizePixel = 0
main.BackgroundTransparency = 0.5
main.ClipsDescendants = true
 
-- [ Suavizar Bordas ]

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = main
 
-- [ Etiqueta ]

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = label

label.Name = "label"
label.Parent = main
label.BackgroundColor3 = Color3.fromRGB(242, 243, 243)
label.BackgroundTransparency = 0.2
label.Size = UDim2.new(1, 0, 0, 30)
label.Font = Enum.Font.SourceSansBold
label.Text = "Shox Hitbox"
label.TextColor3 = Color3.fromRGB(61, 21, 133)
label.TextScaled = true
label.TextWrapped = true
label.BorderSizePixel = 0
 
-- [ Botões - Personalização ]

local function createButton(name, position, text, backgroundColor, textColor)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = main
    button.BackgroundColor3 = backgroundColor
    button.Position = position
    button.Size = UDim2.new(0, 130, 0, 40)
    button.Font = Enum.Font.SourceSans
    button.Text = text
    button.TextColor3 = textColor
    button.TextSize = 23
    button.BorderSizePixel = 1
    button.BackgroundTransparency = 0.4
 
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
 
-- [ Mouse Efeito ]

    button.MouseEnter:Connect(function() button.BackgroundColor3 = Color3.fromRGB(60, 19, 130) end)
    button.MouseLeave:Connect(function() button.BackgroundColor3 = backgroundColor end)
 
    return button
end
 
-- [ Criar Botões ]
HitboxButton = createButton("HitboxButton", UDim2.new(0.6, 0, 0.5, 0), "Hitbox", Color3.fromRGB(242, 243, 243), Color3.fromRGB(0, 0, 0))
MinimizeButton = createButton("MinimizeButton", UDim2.new(0.1, 0, 0.75, 0), "Minimizar", Color3.fromRGB(242, 243, 243), Color3.fromRGB(0, 0, 0))
CloseButton = createButton("CloseButton", UDim2.new(0.6, 0, 0.75, 0), "Fechar", Color3.fromRGB(242, 243, 243), Color3.fromRGB(0, 0, 0))
            MaximizeButton = createButton("MaximizeButton", UDim2.new(0.5, -65, 0.5, 0), "Maximizar", Color3.fromRGB(242, 243, 243), Color3.fromRGB(52, 43, 117))
MaximizeButton.Visible = false
 
-- [ Hitbox - Configurações]

HitboxSizeSlider.Name = "HitboxSizeSlider"
HitboxSizeSlider.Parent = main
HitboxSizeSlider.BackgroundColor3 = Color3.fromRGB(52, 43, 117)
HitboxSizeSlider.Position = UDim2.new(0.1, 0, 0.5, 0.9)
HitboxSizeSlider.Size = UDim2.new(0, 115, 0, 17)
 
SliderButton.Name = "SliderButton"
SliderButton.Parent = HitboxSizeSlider
SliderButton.BackgroundColor3 = Color3.fromRGB(242, 243, 243)
SliderButton.Size = UDim2.new(0, 15, 1, 0)
SliderButton.Text = "H"



SliderLabel.Name = "SliderLabel"
SliderLabel.Parent = main
SliderLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SliderLabel.Position = UDim2.new(0.1, 0, 0.6, 0)
SliderLabel.Size = UDim2.new(0, 180, 0, 30)
SliderLabel.Font = Enum.Font.SourceSansBold
SliderLabel.Text = "Hitbox: 0"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.TextScaled = true
SliderLabel.BorderSizePixel = 1
 
local hitboxActive = false
local hitboxSize = 0
local hitboxTransparency = 0.0
local applyHitboxConnection
 
-- [ Hitbox - Tranparência ]

local TransparencySlider = Instance.new("Frame")
local TransparencySliderButton = Instance.new("TextButton")
local TransparencyLabel = Instance.new("TextLabel")
 
TransparencySlider.Name = "TransparencySlider"
TransparencySlider.Parent = main
TransparencySlider.BackgroundColor3 = Color3.fromRGB(52, 43, 117)
TransparencySlider.Position = UDim2.new(0.1, 0, 0.2, 0)
TransparencySlider.Size = UDim2.new(0, 115, 0, 17)
 
TransparencySliderButton.Name = "TransparencySliderButton"
TransparencySliderButton.Parent = TransparencySlider
TransparencySliderButton.BackgroundColor3 = Color3.fromRGB(242, 243, 243)
TransparencySliderButton.Size = UDim2.new(0, 15, 1, 0)
TransparencySliderButton.Text = "T"
 
TransparencyLabel.Name = "TransparencyLabel"
TransparencyLabel.Parent = main
TransparencyLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TransparencyLabel.Position = UDim2.new(0.1, 0, 0.3, 0) -- Ajusta la posición según sea necesario
TransparencyLabel.Size = UDim2.new(0, 180, 0, 30)
TransparencyLabel.Font = Enum.Font.SourceSansBold
TransparencyLabel.Text = "Transparência: 0.0"
TransparencyLabel.TextColor3 = Color3.fromRGB(242, 243, 243)
TransparencyLabel.TextScaled = true
TransparencyLabel.BorderSizePixel = 1
 
 
-- [ Transparência - Personalização ]

local function updateHitboxTransparency(newTransparency)
    hitboxTransparency = newTransparency
    TransparencyLabel.Text = "Transparência: " .. string.format("%.1f", hitboxTransparency)
end
 
-- [ Painel de Transparência ]

local draggingTransparencySlider = false
TransparencySliderButton.MouseButton1Down:Connect(function() draggingTransparencySlider = true end)
 
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingTransparencySlider = false
    end
end)
 
UserInputService.InputChanged:Connect(function(input)
    if draggingTransparencySlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderX = TransparencySlider.AbsolutePosition.X
        local sliderWidth = TransparencySlider.AbsoluteSize.X
        local newTransparency = math.clamp(((mouseX - sliderX) / sliderWidth), 0, 1)
        TransparencySliderButton.Position = UDim2.new(newTransparency, 0, 0, 0)
        updateHitboxTransparency(math.floor(newTransparency * 10) / 10)
    end
end)
 
-- [ Aplicar Hitbox ]

local function applyHitbox()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = player.Character.HumanoidRootPart
            humanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            humanoidRootPart.Transparency = hitboxTransparency
            humanoidRootPart.BrickColor = BrickColor.new("Really Blue")
            humanoidRootPart.Material = Enum.Material.Neon
            humanoidRootPart.CanCollide = false
        end
    end
end
 
-- [ Restauração ]

local function resetHitbox()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = player.Character.HumanoidRootPart
            humanoidRootPart.Size = Vector3.new(1, 2, 1)
            humanoidRootPart.Transparency = 1
            humanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
            humanoidRootPart.Material = Enum.Material.SmoothPlastic
            humanoidRootPart.CanCollide = false
        end
    end
end
 
-- [ Tamanho da Hitbox ]

local function updateHitboxSize(newSize)
    hitboxSize = newSize
    SliderLabel.Text = "Hitbox: " .. tostring(hitboxSize)
end
 
-- [ Controle/Slider ]

local draggingSlider = false
SliderButton.MouseButton1Down:Connect(function() draggingSlider = true end)
 
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)
 
UserInputService.InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderX = HitboxSizeSlider.AbsolutePosition.X
        local sliderWidth = HitboxSizeSlider.AbsoluteSize.X
        local newSize = math.clamp(math.floor(((mouseX - sliderX) / sliderWidth) * 99) + 2, 2, 100)
        SliderButton.Position = UDim2.new(newSize / 100, 0, 0, 0)
        updateHitboxSize(newSize)
    end
end)
 
-- [ Desativar Hitbox ]

HitboxButton.MouseButton1Down:Connect(function()
    hitboxActive = not hitboxActive
    if hitboxActive then
        applyHitboxConnection = game:GetService('RunService').RenderStepped:Connect(applyHitbox)
        HitboxButton.Text = "Hitbox On"
    else
       if applyHitboxConnection then
            applyHitboxConnection:Disconnect()
            resetHitbox()
        end
        HitboxButton.Text = "Hitbox Off"
    end
end)
 
-- [ Minimizar/Maximizar ]

local function animateGui(targetSize, showMaximizeButton)
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = TweenService:Create(main, tweenInfo, {Size = targetSize})
    tween:Play()
 
    HitboxButton.Visible = showMaximizeButton
    CloseButton.Visible = showMaximizeButton
    MinimizeButton.Visible = showMaximizeButton
    HitboxSizeSlider.Visible = showMaximizeButton
    SliderLabel.Visible = showMaximizeButton
    TransparencyLabel.Visible = showMaximizeButton
    TransparencySlider.Visible = showMaximizeButton
    MaximizeButton.Visible = not showMaximizeButton
end
 
-- [ Minimização ]
MinimizeButton.MouseButton1Down:Connect(function()
    animateGui(UDim2.new(0, 200, 0, 100), false)
end)
 
-- [ Maximização ]
MaximizeButton.MouseButton1Down:Connect(function()
    animateGui(UDim2.new(0, 400, 0, 250), true)
end)
 
-- [ Fechar ]
CloseButton.MouseButton1Down:Connect(function()
    -- *Destroy* o script e o funcionamento.
    if applyHitboxConnection then
        applyHitboxConnection:Disconnect()
        resetHitbox() -- Restaura a Hitbox
    end
 
    -- Destruir Gui
    ScreenGui:Destroy()
end)
 
