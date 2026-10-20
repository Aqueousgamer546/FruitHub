
--// FRUIT HUB | Interface demonstrativa
--// Para usar em um LocalScript no Roblox Studio

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove uma versão anterior
local oldGui = playerGui:FindFirstChild("FruitHub")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local function create(className, properties, parent)
    local obj = Instance.new(className)
    for key, value in pairs(properties) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local purple = Color3.fromRGB(145, 80, 255)
local background = Color3.fromRGB(22, 22, 31)
local panelColor = Color3.fromRGB(32, 32, 45)
local white = Color3.fromRGB(245, 245, 255)

local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(620, 390),
    Position = UDim2.new(0.5, -310, 0.5, -195),
    BackgroundColor3 = background,
    BorderSizePixel = 0,
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 12)}, main)
create("UIStroke", {
    Color = purple,
    Thickness = 1.5,
}, main)

-- Barra superior
local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = panelColor,
    BorderSizePixel = 0,
}, main)
create("UICorner", {CornerRadius = UDim.new(0, 12)}, top)

create("TextLabel", {
    Size = UDim2.new(1, -120, 1, 0),
    Position = UDim2.fromOffset(16, 0),
    BackgroundTransparency = 1,
    Text = "🍇  FRUIT HUB",
    TextColor3 = white,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local close = create("TextButton", {
    Size = UDim2.fromOffset(36, 30),
    Position = UDim2.new(1, -44, 0, 9),
    BackgroundColor3 = Color3.fromRGB(180, 55, 75),
    Text = "X",
    TextColor3 = white,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
}, top)
create("UICorner", {CornerRadius = UDim.new(0, 7)}, close)

local minimize = create("TextButton", {
    Size = UDim2.fromOffset(36, 30),
    Position = UDim2.new(1, -84, 0, 9),
    BackgroundColor3 = background,
    Text = "_",
    TextColor3 = white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
}, top)
create("UICorner", {CornerRadius = UDim.new(0, 7)}, minimize)

-- Barra lateral
local sidebar = create("Frame", {
    Position = UDim2.fromOffset(0, 48),
    Size = UDim2.new(0, 155, 1, -48),
    BackgroundColor3 = Color3.fromRGB(26, 26, 37),
    BorderSizePixel = 0,
}, main)

local content = create("Frame", {
    Position = UDim2.fromOffset(170, 62),
    Size = UDim2.new(1, -185, 1, -76),
    BackgroundTransparency = 1,
}, main)

local status = create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 32),
    Position = UDim2.fromOffset(10, 0),
    BackgroundTransparency = 1,
    Text = "Bem-vindo ao FruitHub!",
    TextColor3 = purple,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageArea = create("Frame", {
    Position = UDim2.fromOffset(10, 42),
    Size = UDim2.new(1, -20, 1, -48),
    BackgroundTransparency = 1,
}, content)

local function clearPage()
    for _, child in ipairs(pageArea:GetChildren()) do
        child:Destroy()
    end
end

local function label(text, y, height)
    return create("TextLabel", {
        Position = UDim2.fromOffset(0, y),
        Size = UDim2.new(1, 0, 0, height or 32),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = white,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
    }, pageArea)
end

local function button(text, y, callback)
    local b = create("TextButton", {
        Position = UDim2.fromOffset(0, y),
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = panelColor,
        Text = text,
        TextColor3 = white,
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true,
    }, pageArea)
    create("UICorner", {CornerRadius = UDim.new(0, 8)}, b)
    create("UIStroke", {Color = purple, Transparency = 0.6}, b)
    b.Activated:Connect(callback)
    return b
end

local pages = {}

pages.Home = function()
    clearPage()
    label("Painel inicial", 0, 30)
    label("Jogador: " .. player.Name, 36)
    label("ID: " .. tostring(player.UserId), 70)
    label("Conta criada: " ..
        player.AccountAge .. " dias atrás", 104)
    label("Horário local do servidor:", 138)
    local clock = label("--:--:--", 170, 35)

    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not clock.Parent then
            connection:Disconnect()
            return
        end
        clock.Text = os.date("%H:%M:%S")
    end)

    button("Atualizar informações", 215, function()
        status.Text = "Informações atualizadas!"
    end)
end

pages.Character = function()
    clearPage()
    label("Informações do personagem", 0, 32)

    local function refresh()
        clearPage()
        label("Personagem", 0, 30)

        local character = player.Character
        local humanoid = character and
            character:FindFirstChildOfClass("Humanoid")
        local root = character and
            character:FindFirstChild("HumanoidRootPart")

        label("Vida: " .. (humanoid and
            math.floor(humanoid.Health) or "Indisponível"), 38)

        label("Velocidade: " .. (humanoid and
            math.floor(humanoid.WalkSpeed) or "Indisponível"), 72)

        if root then
            local p = root.Position
            label(string.format(
                "Posição: X %.1f | Y %.1f | Z %.1f",
                p.X, p.Y, p.Z
            ), 106, 42)
        else
            label("Personagem não encontrado.", 106)
        end

        button("Atualizar", 160, refresh)
    end

    refresh()
end

pages.Settings = function()
    clearPage()
    label("Configurações da interface", 0, 32)

    button("Mudar cor para azul", 45, function()
        purple = Color3.fromRGB(60, 150, 255)
        main:FindFirstChildOfClass("UIStroke").Color = purple
        status.Text = "Tema azul ativado!"
    end)

    button("Mudar cor para roxo", 90, function()
        purple = Color3.fromRGB(145, 80, 255)
        main:FindFirstChildOfClass("UIStroke").Color = purple
        status.Text = "Tema roxo ativado!"
    end)

    button("Mostrar mensagem", 135, function()
        status.Text = "Tudo funcionando! ✨"
    end)
end

local function showPage(name)
    status.Text = "Página: " .. name
    pages[name]()
end

local navItems = {
    {"🏠  Início", "Home"},
    {"🧍  Personagem", "Character"},
    {"⚙️  Configurações", "Settings"},
}

for i, item in ipairs(navItems) do
    local b = create("TextButton", {
        Position = UDim2.fromOffset(8, 12 + (i - 1) * 48),
        Size = UDim2.new(1, -16, 0, 40),
        BackgroundColor3 = panelColor,
        Text = item[1],
        TextColor3 = white,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
    }, sidebar)
    create("UICorner", {CornerRadius = UDim.new(0, 7)}, b)
    b.Activated:Connect(function()
        showPage(item[2])
    end)
end

-- Minimizar e fechar
local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(260, 48)
        or UDim2.fromOffset(620, 390)
    minimize.Text = minimized and "+" or "_"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- Arrastar pela barra superior com mouse ou toque
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

showPage("Home")
print("FruitHub iniciado!")
