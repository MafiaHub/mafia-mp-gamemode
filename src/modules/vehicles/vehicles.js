const vehiclesData = require("./vehiclesData.js");

console.log("[GAMEMODE|MODULES] vehicles.js loaded!");

const spawnCar = function (id, position, rotation) {
	const vehicle = sdk.World.createVehicle(vehiclesData.vehicles[id]);

	vehicle.setPosition(position);
	vehicle.setRotation(rotation);

	return vehicle;
};

const destroyCar = function (vehicle, player) {
	player.sendChat(`[SERVER] Destroy: ${vehicle.toString()}`);
	vehicle.destruct();
};

module.exports = {
	spawnCar,
	destroyCar,
};
