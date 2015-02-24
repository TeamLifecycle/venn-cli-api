homeController = {}
Nightmare = require 'nightmare'
fs = require 'fs'

homeController.index = (req, res) ->
	return res.sendStatus 200

module.exports = homeController
