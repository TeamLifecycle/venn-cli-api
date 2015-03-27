mongoose = require 'mongoose'
Schema   = mongoose.Schema

AppIntegrationSchema = new Schema({
  requiredFields: Array
  integration: Object
  active: Boolean
}, collection: 'app_integrations')

mongoose.model 'AppIntegration', AppIntegrationSchema