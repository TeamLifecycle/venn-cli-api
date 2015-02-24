homeController = {}
Nightmare = require 'nightmare'
fs = require 'fs'
AWS = require 'aws-sdk'
v = require "#{process.env.PWD}/config/vars"
keystructure = require "#{process.env.PWD}/config/keystructure"
_ = require "underscore"

homeController.index = (req, res) ->
	return res.sendStatus 200

homeController.updateKeys = (req, res) ->	
	console.log "update"
	s3 = new (AWS.S3)(params:
	  Bucket: v.AWS.S3_BUCKET.PLATFORMKEYS
	  Key: req.body.appId
	)
	s3.upload { Body: req.body.keys }, ->
		return res.sendStatus(200)

homeController.getParams = (req, res) ->
	console.log "params"
	service = req.params.service
	console.log keystructure.keystructure
	params = _.find keystructure.keystructure, (obj) ->
		console.log obj
		console.log service
		obj.name is service
	return res.status(200).send(params)

homeController.keys = (req, res) ->
	console.log "all"
	return res.status(201).send(keystructure)

module.exports = homeController
