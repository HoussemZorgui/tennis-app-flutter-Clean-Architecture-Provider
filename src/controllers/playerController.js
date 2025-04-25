const Player = require('../models/Player');

exports.addPlayer = async (req, res) => {
  try {
    const { name, age, photoUrl } = req.body;
    const player = new Player({ name, age, photoUrl });
    await player.save();
    res.status(201).json(player);
  } catch (error) {
    res.status(500).json({ error: 'Error adding player' });
  }
};

exports.getAllPlayers = async (req, res) => {
  try {
    const players = await Player.find().sort({ createdAt: -1 });
    res.status(200).json(players);
  } catch (error) {
    res.status(500).json({ error: 'Error fetching players' });
  }
};

exports.getPlayerStats = async (req, res) => {
  try {
    const playerId = req.params.id;
    const player = await Player.findById(playerId);
    
    if (!player) {
      return res.status(404).json({ error: 'Player not found' });
    }
    
    res.status(200).json({
      name: player.name,
      age: player.age,
      photoUrl: player.photoUrl,
      wins: player.wins,
      losses: player.losses,
      matchesPlayed: player.matchesPlayed,
      winPercentage: player.matchesPlayed > 0 
        ? Math.round((player.wins / player.matchesPlayed) * 100) 
        : 0
    });
  } catch (error) {
    res.status(500).json({ error: 'Error fetching player stats' });
  }
};

exports.deletePlayer = async (req, res) => {
  try {
    const playerId = req.params.id;
    await Player.findByIdAndDelete(playerId);
    res.status(200).json({ message: 'Player deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Error deleting player' });
  }
};