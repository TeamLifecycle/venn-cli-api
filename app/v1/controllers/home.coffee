homeController = {}
Nightmare = require 'nightmare'
fs = require 'fs'
AWS = require 'aws-sdk'
v = require "#{process.env.PWD}/config/vars"
keystructure = require "#{process.env.PWD}/config/keystructure"
_ = require "underscore"
supportedPackages = require "#{process.env.PWD}/config/supported_packages"

homeController.index = (req, res) ->
	return res.sendStatus(200)

homeController.health = (req, res) ->
	return res.status(200).send({"status": "ok"})

homeController.keys = (req, res) ->
	return res.status(201).send(keystructure[req.params.service])

homeController.updateKeys = (req, res) ->
	params =
		Bucket: v.AWS.S3_BUCKET.PLATFORMKEYS
		Key: req.body.appId + ".json"
	s3 = new (AWS.S3)(params: params)

	# get existing file so we dont overwrite keys we arent updating
	s3.getObject { }, (error, data) ->
		keysObj = {}
		if error
			console.log 'Failed to retrieve an object: ' + error
		else
			keysObj = JSON.parse(data["Body"].toString())

		for attributename of req.body.keys
			console.log attributename
			service = attributename.split("/")[0]
			key = attributename.split("/")[1]
			value = req.body.keys[attributename]
			keysObj[service] = {} unless keysObj[service]
			keysObj[service][key] = value
		
		s3.upload { Body: JSON.stringify(keysObj, null, 2) }, ->
			return res.sendStatus(200)

homeController.getPackages = (req, res) ->
	lang = req.params.lang
	res.status(200).send supportedPackages[lang]

homeController.installPackages = (req, res) ->
	lang = req.params.lang
	service = req.params.service
	console.log supportedPackages[lang][service]
	res.status(200).send supportedPackages[lang][service]

module.exports = homeController
