express = require 'express'
router = express.Router()

homeController = require "../v1/controllers/home"

router.get '/', homeController.index

module.exports = router