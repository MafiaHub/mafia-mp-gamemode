console.log("[GAMEMODE|MODULES] players.js loaded!");

const heal = function (player) {
    player.setHealth(100.0);
};

module.exports = {
    heal,
};
