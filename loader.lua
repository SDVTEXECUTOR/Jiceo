-- [[ JICEO LOADER - UPDATED VERSION WITH GUI AND ANTI-DUPLICATE ]]
local REQUIRED_GAME_ID = 115893378298440
local LOGO_ID = "rbxassetid://89065201750107"
local PC_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/PCTF"
local MB_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/MBTF"
local EPRESS_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/E-Press"

-- Xóa GUI cũ nếu tồn tại
pcall(function()
    local oldGUI = game:GetService("CoreGui"):FindFirstChild("JiceoLoader")
    if oldGUI then
        oldGUI:Destroy()
    end
end)

-- Tạo GUI chính
local function createGUI()
    -- Tạo ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JiceoLoader"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999 -- Ưu tiên hiển thị cao nhất
    
    -- Kiểm tra và xóa nếu đã tồn tại (lần 2)
    local existingGUI = game:GetService("CoreGui"):FindFirstChild("JiceoLoader")
    if existingGUI and existingGUI ~= screenGui then
        existingGUI:Destroy()
    end
    
    -- Tạo Frame chính
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = false -- Ẩn ban đầu, sẽ hiện sau khi animation
    
    -- Bo góc
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = mainFrame
    
    -- Drop Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = mainFrame
    
    -- Gradient nền
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    })
    gradient.Rotation = 90
    gradient.Parent = mainFrame
    
    -- Tiêu đề
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = titleBar
    
    -- Chỉ bo góc trên
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 40))
    })
    titleGradient.Rotation = 90
    titleGradient.Parent = titleBar
    
    -- Logo hình tròn
    local logoCircle = Instance.new("ImageLabel")
    logoCircle.Name = "Logo"
    logoCircle.Size = UDim2.new(0, 30, 0, 30)
    logoCircle.Position = UDim2.new(0, 10, 0.5, -15)
    logoCircle.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    logoCircle.BackgroundTransparency = 0.5
    logoCircle.Image = LOGO_ID
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = logoCircle
    
    logoCircle.Parent = titleBar
    
    -- Tiêu đề text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, 50, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "! JICEO CHECK !"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Nội dung chính
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -30, 1, -55)
    contentFrame.Position = UDim2.new(0, 15, 0, 45)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    -- Status text
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Đang kiểm tra hệ thống..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 14
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = contentFrame
    
    -- Progress bar
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(1, 0, 0, 4)
    progressBar.Position = UDim2.new(0, 0, 0, 30)
    progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = contentFrame
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBar
    
    local progressFill = Instance.new("Frame")
    progressFill.Name = "ProgressFill"
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = progressFill
    
    -- Device info
    local deviceLabel = Instance.new("TextLabel")
    deviceLabel.Name = "DeviceLabel"
    deviceLabel.Size = UDim2.new(1, 0, 0, 25)
    deviceLabel.Position = UDim2.new(0, 0, 0, 45)
    deviceLabel.BackgroundTransparency = 1
    deviceLabel.Text = "Check Device: Đang kiểm tra..."
    deviceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    deviceLabel.Font = Enum.Font.Gotham
    deviceLabel.TextSize = 13
    deviceLabel.TextXAlignment = Enum.TextXAlignment.Left
    deviceLabel.RichText = true
    deviceLabel.Parent = contentFrame
    
    -- Game info
    local gameLabel = Instance.new("TextLabel")
    gameLabel.Name = "GameLabel"
    gameLabel.Size = UDim2.new(1, 0, 0, 25)
    gameLabel.Position = UDim2.new(0, 0, 0, 70)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Text = "Check Game: Đang kiểm tra..."
    gameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.TextSize = 13
    gameLabel.TextXAlignment = Enum.TextXAlignment.Left
    gameLabel.RichText = true
    gameLabel.Parent = contentFrame
    
    -- Script info
    local scriptLabel = Instance.new("TextLabel")
    scriptLabel.Name = "ScriptLabel"
    scriptLabel.Size = UDim2.new(1, 0, 0, 25)
    scriptLabel.Position = UDim2.new(0, 0, 0, 95)
    scriptLabel.BackgroundTransparency = 1
    scriptLabel.Text = "Script E-Press: Đang tải..."
    scriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptLabel.Font = Enum.Font.Gotham
    scriptLabel.TextSize = 13
    scriptLabel.TextXAlignment = Enum.TextXAlignment.Left
    scriptLabel.RichText = true
    scriptLabel.Parent = contentFrame
    
    -- Main script info
    local mainScriptLabel = Instance.new("TextLabel")
    mainScriptLabel.Name = "MainScriptLabel"
    mainScriptLabel.Size = UDim2.new(1, 0, 0, 25)
    mainScriptLabel.Position = UDim2.new(0, 0, 0, 120)
    mainScriptLabel.BackgroundTransparency = 1
    mainScriptLabel.Text = "Script Chính: Đang chờ..."
    mainScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainScriptLabel.Font = Enum.Font.Gotham
    mainScriptLabel.TextSize = 13
    mainScriptLabel.TextXAlignment = Enum.TextXAlignment.Left
    mainScriptLabel.RichText = true
    mainScriptLabel.Parent = contentFrame
    
    -- Loading animation
    local loadingDots = Instance.new("TextLabel")
    loadingDots.Name = "LoadingDots"
    loadingDots.Size = UDim2.new(0, 50, 0, 20)
    loadingDots.Position = UDim2.new(1, -60, 1, -30)
    loadingDots.BackgroundTransparency = 1
    loadingDots.Text = "..."
    loadingDots.TextColor3 = Color3.fromRGB(150, 150, 255)
    loadingDots.Font = Enum.Font.GothamBold
    loadingDots.TextSize = 20
    loadingDots.TextXAlignment = Enum.TextXAlignment.Right
    loadingDots.Parent = contentFrame
    
    -- Version text (nhỏ góc dưới trái)
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Name = "VersionLabel"
    versionLabel.Size = UDim2.new(0, 100, 0, 20)
    versionLabel.Position = UDim2.new(0, 10, 1, -25)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "v2.0.0"
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    versionLabel.Font = Enum.Font.GothamLight
    versionLabel.TextSize = 11
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = contentFrame
    
    -- Thêm tất cả vào ScreenGui
    mainFrame.Parent = screenGui
    screenGui.Parent = game:GetService("CoreGui")
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        progressFill = progressFill,
        statusLabel = statusLabel,
        deviceLabel = deviceLabel,
        gameLabel = gameLabel,
        scriptLabel = scriptLabel,
        mainScriptLabel = mainScriptLabel,
        loadingDots = loadingDots
    }
end

-- Animation fade in cho GUI
local function fadeInGUI(gui)
    gui.mainFrame.Visible = true
    gui.mainFrame.BackgroundTransparency = 1
    gui.mainFrame.Shadow.ImageTransparency = 1
    
    -- Fade in animation
    local fadeTime = 0.3
    gui.mainFrame:TweenSize(UDim2.new(0, 350, 0, 250), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, fadeTime, true)
    
    for i = 1, 10 do
        gui.mainFrame.BackgroundTransparency = 1 - (i/10)
        gui.mainFrame.Shadow.ImageTransparency = 1 - (i/10)
        wait(fadeTime/10)
    end
    
    gui.mainFrame.BackgroundTransparency = 0
    gui.mainFrame.Shadow.ImageTransparency = 0.5
end

-- Hàm cập nhật progress bar
local function updateProgress(gui, percent, status)
    gui.progressFill:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.3, true)
    if status then
        gui.statusLabel.Text = status
    end
end

-- Hàm cập nhật loading dots
local function startLoadingAnimation(gui)
    local dots = {"", ".", "..", "..."}
    local index = 1
    coroutine.wrap(function()
        while gui.screenGui and gui.screenGui.Parent do
            gui.loadingDots.Text = dots[index]
            index = index % 4 + 1
            wait(0.3)
        end
    end)()
end

-- Hàm tải và chạy script
local function loadScript(url, scriptName, gui, label)
    if label then
        label.Text = scriptName .. ": <font color='#FFFF00'>Đang tải...</font>"
    end
    
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and content and #content > 0 then
        if content:find("<!DOCTYPE html>") or content:find("<html>") then
            if label then
                label.Text = scriptName .. ": <font color='#FF5555'>Lỗi HTML!</font>"
            end
            return false, "HTML error"
        else
            if label then
                label.Text = scriptName .. ": <font color='#55FF55'>Đã tải xong!</font>"
            end
            return true, content
        end
    else
        if label then
            label.Text = scriptName .. ": <font color='#FF5555'>Lỗi kết nối!</font>"
        end
        return false, "Connection error"
    end
end

-- Hàm thông báo
local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = LOGO_ID,
            Duration = 5
        })
    end)
end

-- MAIN EXECUTION
local gui = createGUI()
fadeInGUI(gui) -- Hiệu ứng fade in
startLoadingAnimation(gui)

-- Kiểm tra device
updateProgress(gui, 0.1, "Đang kiểm tra thiết bị...")
wait(0.5)
local UIS = game:GetService("UserInputService")
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local deviceName = isMobile and "Mobile" or "PC"
local deviceColor = isMobile and "#FFD700" or "#00FFFF"
gui.deviceLabel.Text = string.format("Check Device: <font color='%s'>%s</font>", deviceColor, deviceName)

-- Kiểm tra game
updateProgress(gui, 0.2, "Đang kiểm tra game...")
wait(0.5)
local isValidGame = (game.PlaceId == REQUIRED_GAME_ID or game.GameId == REQUIRED_GAME_ID)
local gameStatus = isValidGame and "Hợp lệ" or "Không hợp lệ"
local gameColor = isValidGame and "#55FF55" or "#FF5555"
gui.gameLabel.Text = string.format("Check Game: <font color='%s'>%s</font>", gameColor, gameStatus)

if not isValidGame then
    updateProgress(gui, 1, "Game không được hỗ trợ!")
    gui.gameLabel.Text = "Check Game: <font color='#FF5555'>Không hợp lệ - ID: " .. game.PlaceId .. "</font>"
    wait(2)
    gui.screenGui:Destroy()
    notify("Jiceo Error", "Script không hỗ trợ Game này!")
    return
end

-- Tải E-Press script trước
updateProgress(gui, 0.3, "Đang tải E-Press script...")
local ePressSuccess, ePressContent = loadScript(EPRESS_URL, "Script E-Press", gui, gui.scriptLabel)

if ePressSuccess then
    updateProgress(gui, 0.6, "Đang chạy E-Press...")
    local func, err = loadstring(ePressContent)
    if func then
        local success, result = pcall(func)
        if not success then
            gui.scriptLabel.Text = "Script E-Press: <font color='#FF5555'>Lỗi khi chạy!</font>"
            warn("Lỗi E-Press: " .. tostring(result))
        end
    else
        gui.scriptLabel.Text = "Script E-Press: <font color='#FF5555'>Lỗi biên dịch!</font>"
        warn("Lỗi biên dịch E-Press: " .. tostring(err))
    end
else
    gui.scriptLabel.Text = "Script E-Press: <font color='#FF5555'>Không thể tải!</font>"
end

-- Tải script chính dựa trên device
updateProgress(gui, 0.7, "Đang tải script chính...")
local mainUrl = isMobile and MB_URL or PC_URL
local mainSuccess, mainContent = loadScript(mainUrl, "Script Chính (" .. deviceName .. ")", gui, gui.mainScriptLabel)

if mainSuccess then
    updateProgress(gui, 0.9, "Đang chạy script chính...")
    local func, err = loadstring(mainContent)
    if func then
        local success, result = pcall(func)
        if success then
            updateProgress(gui, 1, "Hoàn tất! Chúc bạn chơi game vui vẻ!")
            gui.mainScriptLabel.Text = "Script Chính: <font color='#55FF55'>Đã chạy thành công!</font>"
            wait(1.5)
            
            -- Fade out animation trước khi xóa
            for i = 1, 10 do
                gui.mainFrame.BackgroundTransparency = i/10
                gui.mainFrame.Shadow.ImageTransparency = 0.5 + (i/20)
                wait(0.03)
            end
            
            gui.screenGui:Destroy()
            notify("Jiceo Success", "Script " .. deviceName .. " đã sẵn sàng!")
        else
            gui.mainScriptLabel.Text = "Script Chính: <font color='#FF5555'>Lỗi khi chạy!</font>"
            notify("Jiceo Error", "Script chính bị lỗi khi chạy!")
        end
    else
        gui.mainScriptLabel.Text = "Script Chính: <font color='#FF5555'>Lỗi biên dịch!</font>"
        notify("Jiceo Error", "Script chính bị lỗi cú pháp!")
    end
else
    gui.mainScriptLabel.Text = "Script Chính: <font color='#FF5555'>Không thể tải!</font>"
    notify("Jiceo Error", "Không thể tải script chính!")
end

-- Giữ GUI thêm 2 giây nếu không tự động đóng
if gui.progressFill.Size.X.Scale < 1 then
    updateProgress(gui, 1, "Hoàn tất!")
    wait(2)
    
    -- Fade out animation
    if gui.screenGui and gui.screenGui.Parent then
        for i = 1, 10 do
            gui.mainFrame.BackgroundTransparency = i/10
            gui.mainFrame.Shadow.ImageTransparency = 0.5 + (i/20)
            wait(0.03)
        end
        gui.screenGui:Destroy()
    end
end

-- Thêm kiểm tra duplicate ở cuối (đề phòng)
pcall(function()
    local allGUIs = game:GetService("CoreGui"):GetChildren()
    local jiceoGUIs = {}
    for _, gui in ipairs(allGUIs) do
        if gui.Name == "JiceoLoader" then
            table.insert(jiceoGUIs, gui)
        end
    end
    
    -- Nếu có nhiều hơn 1 GUI, giữ lại cái mới nhất
    if #jiceoGUIs > 1 then
        for i = 1, #jiceoGUIs - 1 do
            jiceoGUIs[i]:Destroy()
        end
    end
end)
