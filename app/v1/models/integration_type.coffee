mongoose = require 'mongoose'
Schema   = mongoose.Schema

IntegrationTypeSchema = new Schema({
 slug: String
}, collection: 'integration_types')

mongoose.model 'IntegrationType', IntegrationTypeSchema

