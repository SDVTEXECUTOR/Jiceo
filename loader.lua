-- [[ JICEO LOADER - FIXED VERSION ]]
local REQUIRED_GAME_ID = 115893378298440
local LOGO_ID = "rbxassetid://89065201750107"
local PC_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/PCTF"
local MB_URL = "https://raw.githubusercontent.com/SDVTEXECUTOR/Jiceo/refs/heads/main/JiceoSCRIPT/MBTF"

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

-- 1. Kiểm tra ID Game (Cả PlaceId và GameId cho chắc chắn)
if game.PlaceId ~= REQUIRED_GAME_ID and game.GameId ~= REQUIRED_GAME_ID then
    -- Nếu bạn muốn script chạy ở mọi game để test, hãy tạm thời comment 2 dòng dưới này lại
    notify("Jiceo Error", "Script không hỗ trợ Game này! ID: " .. game.PlaceId)
    return
end

-- 2. Kiểm tra thiết bị
local UIS = game:GetService("UserInputService")
-- Cách check mobile chuẩn hơn một chút
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

local finalUrl = isMobile and MB_URL or PC_URL
local deviceName = isMobile and "Mobile" or "PC"

-- 3. Thông báo đang load
notify("Jiceo Loader", "Đang tải bản cho " .. deviceName .. "...")

-- 4. Tải và chạy script
local success, content = pcall(function() 
    return game:HttpGet(finalUrl) 
end)

if success and content and #content > 0 then
    -- Kiểm tra xem nội dung tải về có phải là HTML lỗi không
    if content:find("<!DOCTYPE html>") or content:find("<html>") then
        notify("Jiceo Error", "Lỗi: Link GitHub trả về trang Web (HTML) thay vì Code!")
    else
        notify("Jiceo Success", "Script " .. deviceName .. " đã sẵn sàng!")
        local func, err = loadstring(content)
        if func then
            func()
        else
            warn("Lỗi biên dịch script: " .. tostring(err))
            notify("Jiceo Error", "Script chính bị lỗi cú pháp!")
        end
    end
else
    notify("Jiceo Error", "Lỗi kết nối hoặc file trống!")
end
