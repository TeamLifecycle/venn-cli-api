express = require 'express'
router = express.Router()

homeController = require "./controllers/home"

router.get '/', homeController.index
router.get '/keys/all', homeController.keys
router.get '/keys/:service', homeController.getParams
router.put '/keys', homeController.updateKeys

module.exports = router