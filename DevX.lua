local CONSTANTS = [[
local ENABLED_REMARKS = {
    NATIVE_REMARK = false,
    INLINE_REMARK = true
}
local DECOMPILER_TIMEOUT = 10 -- seconds
local READER_FLOAT_PRECISION = 7 -- up to 99
local SHOW_INSTRUCTION_LINES = true
local SHOW_REFERENCES = false
local SHOW_OPERATION_NAMES = false
local SHOW_MISC_OPERATIONS = false
local LIST_USED_GLOBALS = true
local RETURN_ELAPSED_TIME = false
]]

local function LoadFromUrl(x)
    local BASE_USER = "w-a-e"
    local BASE_BRANCH = "main"
    local BASE_URL = "https://raw.githubusercontent.com/%s/Advanced-Decompiler-V3/%s/%s.lua"

    local loadSuccess, loadResult = pcall(function()
        local formattedUrl = string.format(BASE_URL, BASE_USER, BASE_BRANCH, x)
        return game:HttpGet(formattedUrl, true)
    end)

    if not loadSuccess then
        warn(`({math.random()}) MОDULE FАILЕD ТO LOАD FRОM URL: {loadResult}.`)
        return
    end

    local embedSuccess, embedResult = pcall(function()
        local embeddedResult = string.gsub(loadResult, ";;CONSTANTS HERE;;", CONSTANTS)
        return embeddedResult
    end)

    if not embedSuccess then
        warn(`({math.random()}) FАILЕD TО EMBЕD CОNSTANТS INТО MОDULЕ: {embedResult}.`)
        return
    end

    local success, result = pcall(loadstring, embedResult)
    if not success then
        warn(`({math.random()}) MОDULE FАILЕD ТO LOАDSТRING: {result}.`)
        return
    end

    if type(result) ~= "function" then
        warn(`MОDULE IS {tostring(result)} (function expected)`)
        return
    end

    return result()
end
LoadFromUrl("init")
wait(5)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()