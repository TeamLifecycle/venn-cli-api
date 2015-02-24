express = require 'express'
router = express.Router()

homeController = require "./controllers/home"

router.get '/', homeController.index
router.get '/keys', homeController.keys

module.exports = router