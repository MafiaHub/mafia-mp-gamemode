local test = {}
local CONFIG = require("gamemode/server/config")
local utils = require("gamemode/shared/utils")

-- Race checkpoints
local RACE_CHECKPOINTS = {
    {
        pos = Vector3.new(-1882.6372070312, 97.991386413574, 17.411468505859),
        checked = false
    },
    {
        pos = Vector3.new(-1873.4964599609, 170.01545715332, 17.411466598511),
        checked = false
    },
    {
        pos = Vector3.new(-1901.2390136719, 276.0207824707, 17.411499023438),
        checked = false
    },
    {
        pos = Vector3.new(-1922.8465576172, 352.83349609375, 17.812620162964),
        checked = false
    },
    {
        pos = Vector3.new(-1981.4409179688, 368.4660949707, 17.821891784668),
        checked = false
    },
    {
        pos = Vector3.new(-1940.3259277344, 287.35876464844, 17.411485671997),
        checked = false
    },
    {
        pos = Vector3.new(-1916.4660644531, 190.69819641113, 17.411464691162),
        checked = false
    },
    {
        pos = Vector3.new(-1983.2736816406, 132.26550292969, 17.411474227905),
        checked = false
    },
    {
        pos = Vector3.new(-2058.0090332031, 92.873558044434, 17.411403656006),
        checked = false
    },
    {
        pos = Vector3.new(-2120.0849609375, 68.519203186035, 18.158008575439),
        checked = false
    },
    {
        pos = Vector3.new(-2161.1496582031, 58.796028137207, 18.675073623657),
        checked = false
    },
    {
        pos = Vector3.new(-2223.3479003906, 70.794288635254, 19.670116424561),
        checked = false
    },
    {
        pos = Vector3.new(-2275.3264160156, 139.05973815918, 20.075662612915),
        checked = false
    },
    {
        pos = Vector3.new(-2264.6779785156, 202.92449951172, 18.660356521606),
        checked = false
    },
    {
        pos = Vector3.new(-2269.5610351562, 297.2451171875, 24.176900863647),
        checked = false
    },
    {
        pos = Vector3.new(-2359.4372558594, 269.61569213867, 23.409297943115),
        checked = false
    },
    {
        pos = Vector3.new(-2421.1628417969, 233.2325592041, 31.315940856934),
        checked = false
    },
    {
        pos = Vector3.new(-2483.3232421875, 196.52485656738, 40.128452301025),
        checked = false
    },
    {
        pos = Vector3.new(-2583.0278320312, 138.30078125, 46.49031829834),
        checked = false
    },
    {
        pos = Vector3.new(-2603.0229492188, 68.283172607422, 44.621711730957),
        checked = false
    },
    {
        pos = Vector3.new(-2578.732421875, -14.243927955627, 33.771015167236),
        checked = false
    },
    {
        pos = Vector3.new(-2555.6494140625, -92.069671630859, 22.964550018311),
        checked = false
    },
    {
        pos = Vector3.new(-2546.1879882812, -122.32839202881, 19.555025100708),
        checked = false
    },
    {
        pos = Vector3.new(-2504.5700683594, -177.24676513672, 17.414066314697),
        checked = false
    },
    {
        pos = Vector3.new(-2488.9265136719, -222.91221618652, 17.414064407349),
        checked = false
    },
    {
        pos = Vector3.new(-2467.9191894531, -283.1930847168, 17.414176940918),
        checked = false
    },
    {
        pos = Vector3.new(-2425.6142578125, -364.27026367188, 17.819452285767),
        checked = false
    },
    {
        pos = Vector3.new(-2356.2819824219, -358.18499755859, 17.791097640991),
        checked = false
    },
    {
        pos = Vector3.new(-2281.9353027344, -294.43576049805, 18.718687057495),
        checked = false
    },
    {
        pos = Vector3.new(-2171.5795898438, -315.64303588867, 18.280612945557),
        checked = false
    },
    {
        pos = Vector3.new(-2146.8435058594, -421.40811157227, 17.890377044678),
        checked = false
    },
    {
        pos = Vector3.new(-2093.6867675781, -511.22378540039, 20.39270401001),
        checked = false
    },
    {
        pos = Vector3.new(-2015.8601074219, -502.54901123047, 21.338775634766),
        checked = false
    },
    {
        pos = Vector3.new(-1993.1599121094, -433.18057250977, 19.047542572021),
        checked = false
    },
    {
        pos = Vector3.new(-1998.5728759766, -308.84017944336, 17.442094802856),
        checked = false
    },
    {
        pos = Vector3.new(-1971.1003417969, -208.0200958252, 17.411596298218),
        checked = false
    },
    {
        pos = Vector3.new(-1956.7073974609, -155.30139160156, 17.41157913208),
        checked = false
    },
    {
        pos = Vector3.new(-1927.8037109375, -53.580139160156, 17.411874771118),
        checked = false
    },
    {
        pos = Vector3.new(-1905.6752929688, 26.388650894165, 17.411499023438),
        checked = false
    }
}

-- Race state
local raceStarted = false
local raceStartTime = 0
local currentCheckpoint = 0
local raceVehicles = {} -- Table pour stocker tous les véhicules de course
local registeredPlayers = {} -- Table pour stocker les joueurs inscrits avec leurs infos

-- Positions de spawn
local SPAWN_POSITIONS = {
    {
        vehicle = Vector3.new(-1004.09014892578, -320.06719970703, 2.3282381534576),
        player = Vector3.new(-1006.09014892578, -320.06719970703, 2.3282381534576)
    },
    {
        vehicle = Vector3.new(-999, -320, 2.1),
        player = Vector3.new(-1001, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-994, -320, 2.1),
        player = Vector3.new(-996, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-989, -320, 2.1),
        player = Vector3.new(-991, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-984, -320, 2.1),
        player = Vector3.new(-986, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-979, -320, 2.1),
        player = Vector3.new(-981, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-974, -320, 2.1),
        player = Vector3.new(-976, -320, 2.1)
    },
    {
        vehicle = Vector3.new(-969, -320, 2.1),
        player = Vector3.new(-971, -320, 2.1)
    }
}

-- Function to reset race state
local function resetRaceState()
    raceStarted = false
    raceStartTime = 0
    currentCheckpoint = 0
    for i = 1, #RACE_CHECKPOINTS do
        RACE_CHECKPOINTS[i].checked = false
    end
    raceVehicles = {}
    registeredPlayers = {}
end

-- Function to check distance between two Vector3
local function getDistance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    local dz = pos1.z - pos2.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-- Function to get position suffix
local function getPositionSuffix(pos)
    if pos == 1 then return "er"
    elseif pos == 2 then return "ème"
    else return "ème"
    end
end

-- Function to start countdown
local function startCountdown(player)
    -- Make sure all engines are off at start
    for _, vehicle in pairs(raceVehicles) do
        vehicle:setEngineOn(false)
    end

    local co = coroutine.create(function()
        -- Send countdown to all registered players
        for _, playerData in ipairs(registeredPlayers) do
            playerData.player:sendChat("[RACE] Race starts in 3...")
        end
        coroutine.yield()
        
        for _, playerData in ipairs(registeredPlayers) do
            playerData.player:sendChat("[RACE] 2...")
        end
        coroutine.yield()
        
        for _, playerData in ipairs(registeredPlayers) do
            playerData.player:sendChat("[RACE] 1...")
        end
        coroutine.yield()
        
        for _, playerData in ipairs(registeredPlayers) do
            playerData.player:sendChat("[RACE] GO!")
        end
        
        -- Start the race
        raceStarted = true
        raceStartTime = os.time()
        
        -- Start all engines at GO
        for _, vehicle in pairs(raceVehicles) do
            vehicle:setEngineOn(true)
        end
    end)
    
    -- Register a gamemode update handler to resume the coroutine
    local lastTime = os.time()
    listenEvent("onGamemodeUpdated", function()
        local currentTime = os.time()
        if currentTime - lastTime >= 1 and coroutine.status(co) ~= "dead" then
            coroutine.resume(co)
            lastTime = currentTime
        end
    end)
end

-- Listen for gamemode update to check checkpoints
listenEvent("onGamemodeUpdated", function()
    if not raceStarted then return end
    
    -- Check checkpoints for each registered player
    for _, playerData in ipairs(registeredPlayers) do
        if not playerData.finished then
            local playerVehicle = playerData.vehicle
            if playerVehicle then
                local checkPosition = playerVehicle:getPosition()
                local checkpoint = RACE_CHECKPOINTS[playerData.checkpoints + 1]
                
                if checkpoint and not checkpoint.checked then
                    local distance = getDistance(checkPosition, checkpoint.pos)
                    
                    if distance < 15.0 then
                        playerData.checkpoints = playerData.checkpoints + 1
                        
                        if playerData.checkpoints == #RACE_CHECKPOINTS then
                            -- Race finished for this player
                            playerData.finished = true
                            local raceTime = os.time() - raceStartTime
                            playerData.finishTime = raceTime
                            
                            -- Count how many players finished
                            local position = 1
                            for _, otherPlayer in ipairs(registeredPlayers) do
                                if otherPlayer.finished and otherPlayer.finishTime < raceTime then
                                    position = position + 1
                                end
                            end
                            
                            local suffix = getPositionSuffix(position)
                            playerData.player:sendChat(string.format("[RACE] Congratulations! You finished %d%s in %d seconds!", position, suffix == "er" and "st" or "th", raceTime))
                            
                            -- Check if all players finished
                            local allFinished = true
                            for _, p in ipairs(registeredPlayers) do
                                if not p.finished then
                                    allFinished = false
                                    break
                                end
                            end
                            
                            if allFinished then
                                -- Display final rankings
                                table.sort(registeredPlayers, function(a, b) return a.finishTime < b.finishTime end)
                                for i, p in ipairs(registeredPlayers) do
                                    local s = i == 1 and "st" or "th"
                                    for _, allP in ipairs(registeredPlayers) do
                                        allP.player:sendChat(string.format("[RACE] %d%s place: %s - %d seconds", 
                                            i, s, p.player.nickname, p.finishTime))
                                    end
                                end
                                resetRaceState()
                            end
                        else
                            -- Normal checkpoint
                            playerData.player:sendChat(string.format("[RACE] Checkpoint %d/%d!", playerData.checkpoints, #RACE_CHECKPOINTS))
                        end
                    end
                end
            end
        end
    end
end)

RegisterChatCommand("race", function(player, message, command, args)
    -- Check if player is already registered
    for _, playerData in ipairs(registeredPlayers) do
        if playerData.id == player.id then
            player:sendChat("[RACE] You are already registered for the race!")
            return
        end
    end
    
    -- Check if race is full
    if #registeredPlayers >= 8 then
        player:sendChat("[RACE] Sorry, the race is full! (Maximum 8 players)")
        return
    end
    
    -- Find a free spawn position
    local spawnPos = SPAWN_POSITIONS[#registeredPlayers + 1]
    
    if not spawnPos then
        player:sendChat("[RACE] Error finding spawn position!")
        return
    end
    
    -- Spawn the vehicle
    local vehicle = World.createVehicle("samson_drifter")
    if vehicle == nil then
        player:sendChat("[RACE] Error while creating the vehicle!")
        return
    end

    -- Position the vehicle and player
    vehicle:setPosition(spawnPos.vehicle)
    vehicle:setEngineOn(false)
    player:setPosition(spawnPos.player)
    
    -- Add vehicle to race vehicles list
    table.insert(raceVehicles, vehicle)
    
    -- Add player to registered players with their info
    local playerData = {
        id = player.id,
        nickname = player.nickname,
        player = player,
        checkpoints = 0,
        finished = false,
        vehicle = vehicle,
        spawnPosition = spawnPos
    }
    table.insert(registeredPlayers, playerData)
    
    -- Inform all players about the new registration and remaining slots
    local remainingSlots = 8 - #registeredPlayers
    for _, data in ipairs(registeredPlayers) do
        data.player:sendChat(string.format("[RACE] %s has registered for the race! (%d player%s registered, %d slot%s remaining)", 
            playerData.nickname,
            #registeredPlayers,
            #registeredPlayers > 1 and "s" or "",
            remainingSlots,
            remainingSlots > 1 and "s" or ""
        ))
    end
    
    player:sendChat("[RACE] Vehicle is ready! Get in and use /start to begin the race.")
end)

RegisterChatCommand("start", function(player, message, command, args)
    if not raceVehicles then
        player:sendChat("[RACE] No race in progress. Use /race to start one!")
        return
    end

    if raceStarted then
        player:sendChat("[RACE] A race is already in progress!")
        return
    end

    -- Check if player is registered
    local isRegistered = false
    for _, playerData in ipairs(registeredPlayers) do
        if playerData.id == player.id then
            isRegistered = true
            break
        end
    end

    if not isRegistered then
        player:sendChat("[RACE] You are not registered for the race! Use /race to register.")
        return
    end

    -- Safe vehicle check
    local playerVehicle = nil
    pcall(function()
        playerVehicle = player:getVehicle()
    end)

    if not playerVehicle then
        player:sendChat("[RACE] You must be in the race vehicle!")
        return
    end

    -- Inform all players about race start
    for _, playerData in ipairs(registeredPlayers) do
        playerData.player:sendChat(string.format("[RACE] The race will start with %d player%s!", 
            #registeredPlayers,
            #registeredPlayers > 1 and "s" or ""
        ))
    end

    startCountdown(player)
end)

listenEvent("onVehiclePlayerEnter", function (vehicle, player, seatIndex)
    player:sendChat("You entered a vehicle")
    if not raceVehicles then
        vehicle:setEngineOn(true)
    end
end)

return test
  