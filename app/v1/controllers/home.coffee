homeController = {}
Nightmare = require 'nightmare'
fs = require 'fs'
AWS = require 'aws-sdk'
v = require "#{process.env.PWD}/config/vars"

homeController.index = (req, res) ->
	return res.sendStatus 200

homeController.keys = (req, res) ->	
	s3 = new (AWS.S3)(params:
	  Bucket: v.AWS.S3_BUCKET.PLATFORMKEYS
	  Key: req.body.appId
	)
	s3.upload { Body: "req" }, ->
		return res.sendStatus 200

module.exports = homeController
