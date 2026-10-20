
--// FRUIT HUB V2
--// Interface demonstrativa para Roblox Studio
--// Coloque em um LocalScript dentro de StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Limpa a versão anterior
local previous = playerGui:FindFirstChild("FruitHub")
if previous then
    previous:Destroy()
end

-- Tema
local Theme = {
    Accent = Color3.fromRGB(153, 91, 255),
    Background = Color3.fromRGB(18, 19, 28),
    Sidebar = Color3.fromRGB(23, 24, 35),
    Panel = Color3.fromRGB(31, 33, 47),
    Text = Color3.fromRGB(245, 245, 255),
    Muted = Color3.fromRGB(157, 160, 180),
    Green = Color3.fromRGB(75, 210, 145),
    Red = Color3.fromRGB(235, 90, 110),
}

local gui = Instance.new("ScreenGui")
gui.Name = "FruitHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function create(className, props, parent)
    local obj = Instance.new(className)

    for key, value in pairs(props) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, obj)
end

local function outline(obj, color, transparency)
    create("UIStroke", {
        Color = color or Theme.Accent,
        Thickness = 1,
        Transparency = transparency or 0.5,
    }, obj)
end

-- Janela principal
local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(720, 465),
    Position = UDim2.new(0.5, -360, 0.5, -232),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)

corner(main, 14)
outline(main, Theme.Accent, 0.15)

-- Barra superior
local top = create("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
}, main)

create("TextLabel", {
    Position = UDim2.fromOffset(18, 0),
    Size = UDim2.new(1, -140, 1, 0),
    BackgroundTransparency = 1,
    Text = "🍇  FRUIT HUB",
    TextColor3 = Theme.Text,
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

create("TextLabel", {
    Position = UDim2.new(1, -190, 0, 0),
    Size = UDim2.fromOffset(100, 54),
    BackgroundTransparency = 1,
    Text = "V2.0",
    TextColor3 = Theme.Accent,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
}, top)

local function topButton(text, x, color)
    local b = create("TextButton", {
        Position = UDim2.new(1, x, 0, 12),
        Size = UDim2.fromOffset(32, 30),
        BackgroundColor3 = color,
        Text = text,
        TextColor3 = Theme.Text,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = true,
    }, top)
    corner(b, 8)
    return b
end

local minimize = topButton("_", -76, Theme.Panel)
local close = topButton("X", -38, Theme.Red)

-- Barra lateral
local sidebar = create("Frame", {
    Position = UDim2.fromOffset(0, 54),
    Size = UDim2.new(0, 175, 1, -54),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
}, main)

create("TextLabel", {
    Position = UDim2.fromOffset(15, 13),
    Size = UDim2.new(1, -25, 0, 25),
    BackgroundTransparency = 1,
    Text = "MENU PRINCIPAL",
    TextColor3 = Theme.Muted,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, sidebar)

local nav = create("Frame", {
    Position = UDim2.fromOffset(8, 48),
    Size = UDim2.new(1, -16, 0, 220),
    BackgroundTransparency = 1,
}, sidebar)

create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)

local footer = create("TextLabel", {
    Position = UDim2.new(0, 12, 1, -48),
    Size = UDim2.new(1, -24, 0, 38),
    BackgroundTransparency = 1,
    Text = "FRUIT HUB  •  STUDIO",
    TextColor3 = Theme.Muted,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextWrapped = true,
}, sidebar)

-- Área principal
local content = create("Frame", {
    Position = UDim2.fromOffset(190, 68),
    Size = UDim2.new(1, -205, 1, -82),
    BackgroundTransparency = 1,
}, main)

local pageTitle = create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundTransparency = 1,
    Text = "Dashboard",
    TextColor3 = Theme.Text,
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageSubtitle = create("TextLabel", {
    Position = UDim2.fromOffset(0, 32),
    Size = UDim2.new(1, 0, 0, 24),
    BackgroundTransparency = 1,
    Text = "Visão geral do seu personagem",
    TextColor3 = Theme.Muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageArea = create("ScrollingFrame", {
    Position = UDim2.fromOffset(0, 63),
    Size = UDim2.new(1, 0, 1, -63),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Accent,
    CanvasSize = UDim2.fromOffset(0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

create("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, pageArea)

create("UIPadding", {
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 10),
}, pageArea)

-- Utilitários de interface
local pageConnections = {}
local selectedPage = "Dashboard"
local buttons = {}

local function clearPage()
    for _, connection in ipairs(pageConnections) do
        connection:Disconnect()
    end
    table.clear(pageConnections)

    for _, child in ipairs(pageArea:GetChildren()) do
        if not child:IsA("UIListLayout")
            and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function makeLabel(text, height, color, size)
    return create("TextLabel", {
        Size = UDim2.new(1, -4, 0, height or 30),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or Theme.Text,
        TextSize = size or 13,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.None,
    }, pageArea)
end

local function makePanel(title, description)
    local panel = create("Frame", {
        Size = UDim2.new(1, -5, 0, 95),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
    }, pageArea)

    corner(panel, 10)
    outline(panel, Theme.Accent, 0.8)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 9),
        Size = UDim2.new(1, -26, 0, 24),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, panel)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 35),
        Size = UDim2.new(1, -26, 0, 48),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Theme.Muted,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    }, panel)

    return panel
end

local function makeButton(text, callback)
    local b = create("TextButton", {
        Size = UDim2.new(1, -5, 0, 38),
        BackgroundColor3 = Theme.Panel,
        Text = text,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true,
    }, pageArea)

    corner(b, 8)
    outline(b, Theme.Accent, 0.55)

    b.Activated:Connect(callback)
    return b
end

local function makeStat(title, value)
    local card = create("Frame", {
        Size = UDim2.new(1, -5, 0, 66),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
    }, pageArea)

    corner(card, 9)

    create("TextLabel", {
        Position = UDim2.fromOffset(12, 7),
        Size = UDim2.new(1, -24, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Muted,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    local valueLabel = create("TextLabel", {
        Position = UDim2.fromOffset(12, 30),
        Size = UDim2.new(1, -24, 0, 27),
        BackgroundTransparency = 1,
        Text = value,
        TextColor3 = Theme.Accent,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    return valueLabel
end

-- Páginas
local pages = {}

pages.Dashboard = function()
    clearPage()

    makePanel(
        "Bem-vindo ao Fruit Hub!",
        "Seu painel pessoal de informações e personalização."
    )

    makeStat("JOGADOR", player.Name)
    makeStat("USER ID", tostring(player.UserId))
    makeStat("IDADE DA CONTA", tostring(player.AccountAge) .. " dias")

    local clock = makeStat("HORÁRIO LOCAL", os.date("%H:%M:%S"))

    local connection = RunService.Heartbeat:Connect(function()
        if clock.Parent then
            clock.Text = os.date("%H:%M:%S")
        end
    end)
    table.insert(pageConnections, connection)

    makeButton("Atualizar painel", function()
        showPage("Dashboard")
    end)
end

pages.Player = function()
    clearPage()

    makePanel(
        "Informações do personagem",
        "Os valores abaixo são lidos do personagem atual."
    )

    local function getCharacterInfo()
        local character = player.Character
        local humanoid = character
            and character:FindFirstChildOfClass("Humanoid")
        local root = character
            and character:FindFirstChild("HumanoidRootPart")

        local health = humanoid
            and string.format("%.0f / %.0f",
                humanoid.Health, humanoid.MaxHealth)
            or "Indisponível"

        local speed = humanoid
            and tostring(math.floor(humanoid.WalkSpeed))
            or "Indisponível"

        local position = "Indisponível"
        if root then
            local p = root.Position
            position = string.format(
                "%.1f, %.1f, %.1f", p.X, p.Y, p.Z
            )
        end

        return health, speed, position
    end

    local health = makeStat("VIDA ATUAL", "...")
    local speed = makeStat("VELOCIDADE DE CAMINHADA", "...")
    local position = makeStat("POSIÇÃO (X, Y, Z)", "...")

    local function refresh()
        local h, s, p = getCharacterInfo()
        health.Text = h
        speed.Text = s
        position.Text = p
    end

    refresh()
    makeButton("Atualizar informações", refresh)

    local connection = RunService.Heartbeat:Connect(refresh)
    table.insert(pageConnections, connection)
end

pages.Fruits = function()
    clearPage()

    makePanel(
        "Catálogo demonstrativo",
        "Exemplos de cartões de frutas. Estes dados não representam seu inventário real."
    )

    local fruits = {
        {
            name = "Flame",
            type = "Elemental",
            rarity = "Comum",
            icon = "🔥",
        },
        {
            name = "Ice",
            type = "Elemental",
            rarity = "Comum",
            icon = "❄️",
        },
        {
            name = "Light",
            type = "Elemental",
            rarity = "Rara",
            icon = "✨",
        },
        {
            name = "Magma",
            type = "Elemental",
            rarity = "Rara",
            icon = "🌋",
        },
        {
            name = "Buddha",
            type = "Beast",
            rarity = "Rara",
            icon = "🌟",
        },
        {
            name = "Dragon",
            type = "Beast",
            rarity = "Lendária",
            icon = "🐉",
        },
    }

    local search = create("TextBox", {
        Size = UDim2.new(1, -5, 0, 38),
        BackgroundColor3 = Theme.Panel,
        Text = "",
        PlaceholderText = "Buscar uma fruta...",
        PlaceholderColor3 = Theme.Muted,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
    }, pageArea)
    corner(search, 8)
    outline(search, Theme.Accent, 0.6)

    local results = create("Frame", {
        Size = UDim2.new(1, -5, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, pageArea)

    create("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, results)

    local function renderResults(query)
        for _, child in ipairs(results:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end

        query = string.lower(query or "")

        for _, fruit in ipairs(fruits) do
            if string.find(string.lower(fruit.name), query, 1, true) then
                local row = create("Frame", {
                    Size = UDim2.new(1, 0, 0, 68),
                    BackgroundColor3 = Theme.Panel,
                    BorderSizePixel = 0,
                }, results)

                corner(row, 8)

                create("TextLabel", {
                    Position = UDim2.fromOffset(10, 0),
                    Size = UDim2.fromOffset(42, 68),
                    BackgroundTransparency = 1,
                    Text = fruit.icon,
                    TextSize = 24,
                }, row)

                create("TextLabel", {
                    Position = UDim2.fromOffset(58, 8),
                    Size = UDim2.new(1, -70, 0, 24),
                    BackgroundTransparency = 1,
                    Text = fruit.name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, row)

                create("TextLabel", {
                    Position = UDim2.fromOffset(58, 32),
                    Size = UDim2.new(1, -70, 0, 23),
                    BackgroundTransparency = 1,
                    Text = fruit.type .. " • " .. fruit.rarity,
                    TextColor3 = Theme.Muted,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, row)
            end
        end
    end

    search:GetPropertyChangedSignal("Text"):Connect(function()
        renderResults(search.Text)
    end)

    renderResults("")
end

pages.Settings = function()
    clearPage()

    makePanel(
        "Personalização",
        "Mude a aparência da interface. As alterações duram até fechar o jogo."
    )

    makeButton("Tema roxo", function()
        Theme.Accent = Color3.fromRGB(153, 91, 255)
        applyTheme()
    end)

    makeButton("Tema azul", function()
        Theme.Accent = Color3.fromRGB(65, 155, 255)
        applyTheme()
    end)

    makeButton("Tema verde", function()
        Theme.Accent = Color3.fromRGB(60, 205, 145)
        applyTheme()
    end)

    makeButton("Tema rosa", function()
        Theme.Accent = Color3.fromRGB(255, 90, 170)
        applyTheme()
    end)

    makePanel(
        "Controles",
        "Use o botão minimizar para recolher a janela e X para fechá-la."
    )
end

-- Navegação
local pageInfo = {
    {"⌂", "Dashboard", "Dashboard"},
    {"◉", "Player", "Player"},
    {"✦", "Fruits", "Fruits"},
    {"⚙", "Settings", "Settings"},
}

local function updateNavigation()
    for name, buttonObject in pairs(buttons) do
        local active = name == selectedPage
        buttonObject.BackgroundColor3 = active
            and Theme.Accent or Theme.Panel
    end
end

function applyTheme()
    local stroke = main:FindFirstChildOfClass("UIStroke")
    if stroke then
        stroke.Color = Theme.Accent
    end

    for _, object in ipairs(gui:GetDescendants()) do
        if object:IsA("UIStroke") then
            object.Color = Theme.Accent
        end
    end

    pageTitle.TextColor3 = Theme.Accent
    updateNavigation()
end

function showPage(name)
    if not pages[name] then
        return
    end

    selectedPage = name
    pageTitle.Text = name
    pageSubtitle.Text = ({
        Dashboard = "Visão geral e informações da conta",
        Player = "Dados do personagem atual",
        Fruits = "Catálogo ilustrativo de frutas",
        Settings = "Personalize a interface",
    })[name] or ""

    updateNavigation()
    pages[name]()
end

for index, info in ipairs(pageInfo) do
    local icon, name = info[1], info[2]

    local b = create("TextButton", {
        Name = name .. "Button",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.Panel,
        Text = icon .. "   " .. name,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        LayoutOrder = index,
        AutoButtonColor = true,
    }, nav)

    corner(b, 8)
    buttons[name] = b

    b.Activated:Connect(function()
        showPage(name)
    end)
end

-- Minimizar
local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized

    local target = minimized
        and UDim2.fromOffset(300, 54)
        or UDim2.fromOffset(720, 465)

    TweenService:Create(
        main,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad),
        {Size = target}
    ):Play()

    minimize.Text = minimized and "+" or "_"
end)

-- Fechar
close.Activated:Connect(function()
    gui:Destroy()
end)

-- Arrastar pela barra superior
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

-- Inicialização
showPage("Dashboard")
print("FruitHub V2 iniciado!")
