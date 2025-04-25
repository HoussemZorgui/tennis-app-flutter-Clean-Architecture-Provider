const mongoose = require('mongoose');

const matchSchema = new mongoose.Schema({
  player1: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  player2: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  winner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  loser: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  player1Score: {
    type: Number,
    default: 0
  },
  player2Score: {
    type: Number,
    default: 0
  },
  datePlayed: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('Match', matchSchema);