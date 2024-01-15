const weatherData = require("../environment/weather_data.js");

console.log("[GAMEMODE|MODULES] enviroment.js loaded!");

const setWeather = function (id) {
    console.log(`[GAMEMODE] Weather set: ${weatherData.weather[id]}`);
    sdk.Environment.setWeather(weatherData.weather[id]);
};

const getWeather = function () {};

module.exports = {
    setWeather,
};
