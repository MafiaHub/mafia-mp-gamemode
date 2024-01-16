const teleportsData = require("../modules/teleports/teleports_data.js");

sdk.on("playerConnected", (player) => {
	console.log(`[GAMEMODE] Player ${player.getNickname()} connected!`);
	player.sendChatToAll(
		`[SERVER] ${player.getNickname()} has joined the session!`
	);

	// player.addWeapon(20, 200); // TODO: Not working yet
	player.setPosition(teleportsData.teleports["spawn"]);
	player.sendChat(`[SERVER] Welcome ${player.getNickname()}!`);
});

sdk.on("playerDisconnected", (player) => {
	console.log(`[GAMEMODE] Player ${player.getNickname()} disconnected!`);
	player.sendChatToAll(
		`[SERVER] ${player.getNickname()} has left the session!`
	);
});

sdk.on("playerDied", (player) => {
	console.log(`[GAMEMODE] Player ${player.getNickname()} died!`);
	player.sendChatToAll(`[SERVER] Player ${player.getNickname()} died!`);

	// Respawn the player
	player.setHealth(100.0);
	player.setPosition(teleportsData.teleports["spawn"]);
});

module.exports = {};
