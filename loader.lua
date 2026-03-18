-- [[ JICEO LOADER - VERCEL VERSION ]]
local REQUIRED_GAME_ID = 115893378298440
local LOGO_ID = "rbxassetid://89065201750107"
local PC_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/PCTF"
local MB_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/MBTF"

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = LOGO_ID,
        Duration = 5
    })
end

-- 1. Check Game
if game.PlaceId ~= REQUIRED_GAME_ID then
    notify("Jiceo Error", "Script không hỗ trợ Game này!")
    return
end

-- 2. Check Device
local UIS = game:GetService("UserInputService")
local isMobile = (UIS.TouchEnabled and not UIS.KeyboardEnabled)
local finalUrl = isMobile and MB_URL or PC_URL

-- 3. Notify Loading
notify("Jiceo Loader", "Đang tải bản cho " .. (isMobile and "Mobile" or "PC") .. "...")

-- 4. Load Main Script
local success, content = pcall(function() return game:HttpGet(finalUrl) end)

if success then
    notify("Jiceo Success", "Script đã sẵn sàng!")
    loadstring(content)()
else
    notify("Jiceo Error", "Lỗi kết nối GitHub!")
end
