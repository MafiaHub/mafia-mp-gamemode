const weatherData = require("./weatherData.js");

console.log("[GAMEMODE|MODULES] enviroment.js loaded!");

const setWeather = function (id) {
	sdk.Environment.setWeather(weatherData.weather[id]);
};

const getWeather = function () {};

module.exports = {
	setWeather,
};
