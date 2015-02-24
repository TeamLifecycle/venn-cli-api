express = require 'express'
router = express.Router()

homeController = require "./controllers/home"

router.get '/', homeController.index

module.exports = router