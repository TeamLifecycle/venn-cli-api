@PATH =
	v1:
		MODELS: "#{process.env.PWD}/app/v1/models"
		CONTROLLERS: "#{process.env.PWD}/app/v1/controllers"
		SERVICES: "#{process.env.PWD}/app/v1/services"
@AWS =
	S3_BUCKET:
		PLATFORMKEYS: 'venn-platform-keys'