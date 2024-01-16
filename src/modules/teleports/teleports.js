const teleportsData = require("./teleportsData");

console.log("[GAMEMODE|MODULES] teleports.js loaded!");

const teleport = function (player, args) {
	const target = player.getVehicle() || player;
	const spot = /[a-zA-Z]/.test(args)
		? teleportsData.teleports[args]
		: sdk.Vector3.apply(null, args.slice(0, 3).map(parseFloat));

	target.setPosition(spot);
};

module.exports = {
	teleport,
};
