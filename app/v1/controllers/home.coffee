homeController = {}

homeController.index = (req, res) ->
	return res.json
		message: "welcome"
		version: "1"

module.exports = homeController
