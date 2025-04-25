const express = require('express');
const router = express.Router();
const matchController = require('../controllers/matchController');

router.post('/generate', matchController.generateRandomMatch);
router.get('/', matchController.getAllMatches);

module.exports = router;