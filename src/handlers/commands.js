const vehicles = require("../modules/vehicles/vehicles.js");
const enviroment = require("../modules/environment/environment.js");
const teleports = require("../modules/teleports/teleports.js");
const players = require("../modules/players/players.js");
const teleportsData = require("../modules/teleports/teleportsData.js");

console.log("[GAMEMODE|HANDLERS] commands.js loaded!");

sdk.on("chatCommand", (player, message, command, args) => {
	console.log(`[GAMEMODE] Player ${player.getNickname()} used: ${message}`);
	const playerVehicle = player.getVehicle();
	const isArgs = Object.keys(args).length > 0;

	switch (command) {
		// Position
		case "spawn":
			player.setPosition(teleportsData.teleports[spawn]);
			player.sendChat(`[SERVER] Teleported to spawn!`);
			break;

		case "tp":
			if (isArgs) {
				teleports.teleport(player, args);
			}
			break;

		case "pos":
			console.log(player.getPosition().toString());
			player.sendChat(
				`[SERVER] Player ${player.getNickname()} position: ${player
					.getPosition()
					.toString()}`
			);
			break;

		// Vehicles
		case "veh":
			if (isArgs) {
				vehicles.spawnCar(
					args[0],
					player.getPosition(),
					player.getRotation()
				);
			}
			break;

		case "destroy":
			if (playerVehicle) {
				vehicles.destroyCar(playerVehicle, player);
			}
			break;

		case "plate":
			if (playerVehicle) {
				if (isArgs) {
					player.sendChat(
						`[SERVER] Set plate: ${playerVehicle.getLicensePlate()} (${
							args[0]
						})`
					);
					playerVehicle.setLicensePlate(args[0]);
				} else {
					player.sendChat(
						`[SERVER] Plate: ${playerVehicle.getLicensePlate()}`
					);
				}
			}
			break;

		// Players
		case "heal":
			player.setHealth(100.0);
			break;

		// Environment
		case "weather":
			if (isArgs) {
				enviroment.setWeather(args[0]);
			}
			break;

		// Stuff
		case "args":
			sdk.Chat.sendToAll(
				`[SERVER] Player ${player.getNickname()} used /args with args: ${args}`
			);
			break;

		case "test":
			sdk.ui.DisplayBannerMessage("test", "test");
			break;

		default:
			sdk.Game.Helpers.Ui.sendToPlayer(
				player,
				`[SERVER] Unknown command "${command}"`
			);
			break;
	}
});
