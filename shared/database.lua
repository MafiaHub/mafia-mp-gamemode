---@class Database
local database = {}


local DB_FILE = "gamemode/data/players.json"


local function readFile(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read("*all")
    file:close()
    return content
end

local function writeFile(path, content)

    os.execute("mkdir gamemode\\data 2>nul")
    
    local file = io.open(path, "w")
    if not file then return false end
    file:write(content)
    file:close()
    return true
end


local function tableToJson(t)
    if type(t) ~= "table" then return tostring(t) end
    
    local json = "{"
    local first = true
    for k, v in pairs(t) do
        if not first then json = json .. "," end
        first = false

        if type(v) == "string" then
            v = v:gsub('"', '\\"')
            json = json .. string.format('"%s":"%s"', k, v)
        else
            json = json .. string.format('"%s":%s', k, tostring(v))
        end
    end
    json = json .. "}"
    return json
end

local function jsonToTable(jsonStr)
    if not jsonStr or jsonStr == "" then return {} end
    

    jsonStr = jsonStr:gsub("^%s*{", ""):gsub("}%s*$", "")
    
    local result = {}

    for key, value in jsonStr:gmatch('"([^"]+)":"([^"]+)"') do
        result[key] = value
    end
    for key, value in jsonStr:gmatch('"([^"]+)":(%d+)') do
        result[key] = tonumber(value)
    end
    
    return result
end


local function loadDatabase()
    local content = readFile(DB_FILE)
    if not content then return {} end
    return jsonToTable(content)
end

local function saveDatabase(data)
    return writeFile(DB_FILE, tableToJson(data))
end

---@return boolean 
function database.connect()
    local success = saveDatabase({})
    if not success then
        Console.log("Erreur: Impossible d'accéder au fichier de données")
        return false
    end
    Console.log("Base de données JSON initialisée avec succès")
    return true
end

---@param player Player
function database.savePlayer(player)
    if not player then return false end
    
    local data = loadDatabase()
    data[player.nickname] = {
        nickname = player.nickname,
        last_login = os.date("%Y-%m-%d %H:%M:%S"),
        login_count = (data[player.nickname] and data[player.nickname].login_count or 0) + 1
    }
    
    return saveDatabase(data)
end

---@param nickname string
---@return table|nil
function database.getPlayer(nickname)
    if not nickname then return nil end
    
    local data = loadDatabase()
    return data[nickname]
end


---@return table
function database.getAllPlayers()
    return loadDatabase()
end

return database 