express = require 'express'
router = express.Router()

homeController = require "./controllers/home"

router.get '/', homeController.index
router.get '/health', homeController.health
router.get '/keys/:service', homeController.keys
router.put '/keys', homeController.updateKeys
router.get '/packages/:lang', homeController.getPackages
router.get '/install/:lang/:service', homeController.installPackages

module.exports = router