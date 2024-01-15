// Modules
const vehicles = require("./src/modules/vehicles/vehicles.js");
const environment = require("./src/modules/environment/environment.js");
const teleports = require("./src/modules/teleports/teleports.js");
const players = require("./src/modules/players/players.js");

// Data
const vehiclesData = require("./src/modules/vehicles/vehicles_data.js");
const weatherData = require("./src/modules/environment/weather_data.js");
const teleportsData = require("./src/modules/teleports/teleports_data.js");

// Handlers
const commandsHandler = require("./src/handlers/commands.js");
const playersHandler = require("./src/handlers/players.js");

sdk.on("gamemodeLoaded", () => {
    // Logs
    console.log("[GAMEMODE] Racing gamemode loaded!");

    // Enviroment
    sdk.Environment.setWeather(weatherData.weather[1]);
    vehicles.spawnCars(vehiclesData.vehicleSpawns);
});
