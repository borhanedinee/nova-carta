const express = require('express');
const { fetchSearchKeys, addSearchKey } = require('../controllers/searchKeysController');

const recentlysearchedRouter = express.Router()


recentlysearchedRouter.get('/api/recentlysearched/:userid', fetchSearchKeys)
recentlysearchedRouter.post('/api/recentlysearched/addsearchkey/', addSearchKey)


module.exports = recentlysearchedRouter;