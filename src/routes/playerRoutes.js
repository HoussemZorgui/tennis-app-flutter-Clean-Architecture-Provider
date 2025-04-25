const express = require('express');
const router = express.Router();
const playerController = require('../controllers/playerController');

router.post('/', playerController.addPlayer);
router.get('/', playerController.getAllPlayers);
router.get('/:id/stats', playerController.getPlayerStats);
router.delete('/:id', playerController.deletePlayer);

module.exports = router;