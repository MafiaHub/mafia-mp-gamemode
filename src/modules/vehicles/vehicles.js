const vehiclesData = require("../vehicles/vehicles_data.js");

console.log("[GAMEMODE|MODULES] vehicles.js loaded!");

const spawnCars = function (carList) {
    for (const veh of carList) {
        const car = sdk.World.createVehicle(veh.modelName);
        car.setPosition(veh.pos);
        car.setRotation(veh.rot);
    }
    console.log(`[GAMEMODE] spawned ${carList.length} vehicles!`);
};

const setPlate = function (vehicle, plateNumber) {
    if (vehicle) {
        vehicle.setLicensePlate(plateNumber);
    }
};

const getPlate = function (vehicle, player) {
    if (vehicle) {
        player.sendChat(`[SERVER] Plate: ${vehicle.getLicensePlate()}`);
    }
};

const spawnCar = function (player, id) {
    const position = player.getPosition();
    const rotation = player.getRotation();
    const vehicle = sdk.World.createVehicle(vehiclesData.vehicles[id]);

    vehicle.setPosition(position);
    vehicle.setRotation(rotation);
};

const destroyCar = function (vehicle, player) {
    if (vehicle) {
        player.sendChat(`[SERVER] Destroy: ${vehicle.toString()}`);
        vehicle.destruct();
    }
};

module.exports = {
    spawnCars,
    spawnCar,
    destroyCar,
    setPlate,
    getPlate,
};
