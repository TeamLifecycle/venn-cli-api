homeController = {}
v = require "#{process.env.PWD}/config/vars"
# h = require "#{v.HELPERS}"
mongoose = require "mongoose"
require "#{v.PATH.v1.MODELS}/app_integration"
require "#{v.PATH.v1.MODELS}/integration_type"
AppIntegration = mongoose.models.AppIntegration
IntegrationType = mongoose.models.IntegrationType
MyObjectId = mongoose.Types.ObjectId
_ = require "underscore"

homeController.index = (req, res) ->
	return res.sendStatus(200)

homeController.health = (req, res) ->
	return res.status(200).send({"status": "ok"})

homeController.getKeysForApp = (req, res) ->
	# console.log "hi", req.body.slug
	IntegrationType.findOne
		slug: req.body.slug
	, (err, type) ->
		console.log req.body.appId, type._id
		AppIntegration.find
			app: new MyObjectId(req.body.appId)
			"integration.type._id": new MyObjectId(type._id)
		, (err, appIntegrations) ->
			# console.log appIntegrations
			console.error err if err
			keys = {}
			_.each appIntegrations, (appint) ->
				keys[appint.integration.slug] = appint.requiredFields
			return res.status(200).send(keysToObj(keys))


keysToObj = (obj) ->
	console.log obj
	bigObj = {}
	for slug,valuesArray of obj
		bigObj[slug] = arrayToObject(valuesArray)
	bigObj


arrayToObject = (arr) ->
	obj = {}
	for a in arr
		obj[a.slug] = a.value
	obj

# homeController.keys = (req, res) ->
# 	return res.status(201).send(keystructure[req.params.service])

# homeController.updateKeys = (req, res) ->
# 	params =
# 		Bucket: v.AWS.S3_BUCKET.PLATFORMKEYS
# 		Key: req.body.appId + ".json"
# 	s3 = new (AWS.S3)(params: params)

# 	# get existing file so we dont overwrite keys we arent updating
# 	s3.getObject { }, (error, data) ->
# 		keysObj = {}
# 		if error
# 			console.error 'Failed to retrieve an object: ' + error
# 		else
# 			keysObj = JSON.parse(data["Body"].toString())

# 		for attributename of req.body.keys
# 			service = attributename.split("/")[0]
# 			key = attributename.split("/")[1]
# 			value = req.body.keys[attributename]
# 			keysObj[service] = {} unless keysObj[service]
# 			keysObj[service][key] = value
		
# 		s3.upload { Body: JSON.stringify(keysObj, null, 2) }, ->
# 			return res.status(200).send supportedPackages[req.params.lang][req.params.service]

# homeController.getPackages = (req, res) ->
# 	lang = req.params.lang
# 	res.status(200).send supportedPackages[lang]

# homeController.installPackages = (req, res) ->
# 	lang = req.params.lang
# 	service = req.params.service

# 	# insert api key into configuredMsg
# 	serviceResponse = supportedPackages[lang][service]
# 	stringKey = "\"" + req.query.key + "\""
# 	configuredMsg = serviceResponse["configuredMsg"].replace("API_KEY", stringKey)
# 	serviceResponse.configuredMsg = configuredMsg
	
# 	res.status(200).send supportedPackages[lang][service]

module.exports = homeController
