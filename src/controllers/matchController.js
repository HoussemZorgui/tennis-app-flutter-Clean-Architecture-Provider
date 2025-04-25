const Match = require('../models/Match');
const Player = require('../models/Player');


exports.getAllMatches = async (req, res) => {
    try {
      const matches = await Match.find()
        .populate('player1', 'name photoUrl')
        .populate('player2', 'name photoUrl')
        .populate('winner', 'name')
        .sort({ datePlayed: -1 });
      
      res.status(200).json(matches);
    } catch (error) {
      res.status(500).json({ error: 'Error fetching matches' });
    }
  };
  

exports.generateRandomMatch = async (req, res) => {
    try {
      const players = await Player.find();
      
      if (players.length < 2) {
        return res.status(400).json({ error: 'Need at least 2 players to generate a match' });
      }
      
      // Sélection aléatoire de deux joueurs différents
      const [player1, player2] = getTwoRandomPlayers(players);
      
      // Génération des scores (simplifiée)
      const player1Score = Math.floor(Math.random() * 3);
      const player2Score = (player1Score === 2) ? Math.floor(Math.random() * 2) : 3 - player1Score;
      
      // Détermination du gagnant
      const winner = player1Score > player2Score ? player1 : player2;
      const loser = player1Score > player2Score ? player2 : player1;
      
      // Création du match
      const match = new Match({
        player1: player1._id,
        player2: player2._id,
        winner: winner._id,
        loser: loser._id,
        player1Score,
        player2Score
      });
      
      await match.save();
      
      // Mise à jour des statistiques
      await updatePlayerStats(winner._id, loser._id);
      
      res.status(201).json(match);
    } catch (error) {
      console.error('Error generating match:', error);
      res.status(500).json({ error: 'Error generating match', details: error.message });
    }
  };
  
  // Fonctions helper
  function getTwoRandomPlayers(players) {
    let player1, player2;
    do {
      player1 = players[Math.floor(Math.random() * players.length)];
      player2 = players[Math.floor(Math.random() * players.length)];
    } while (player1._id.equals(player2._id));
    return [player1, player2];
  }
  
  async function updatePlayerStats(winnerId, loserId) {
    await Player.findByIdAndUpdate(winnerId, { $inc: { wins: 1, matchesPlayed: 1 } });
    await Player.findByIdAndUpdate(loserId, { $inc: { losses: 1, matchesPlayed: 1 } });
  }