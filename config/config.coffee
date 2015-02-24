path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'api'
    port: process.env.PORT || 3000
    db: process.env.MONGO_URL || 'mongodb://localhost/api-development'

  test:
    root: rootPath
    app:
      name: 'api'
    port: process.env.PORT || 80
    db: process.env.MONGO_URL || 'mongodb://localhost/api-test'

  production:
    root: rootPath
    app:
      name: 'api'
    port: process.env.PORT || 80
    db: process.env.MONGO_URL || 'mongodb://localhost/api-production'

process.env['AWS_ACCESS_KEY_ID'] = process.env.AWS_ACCESS_KEY_ID || 'AKIAJBFT6MGV4CYS65AA'
process.env['AWS_SECRET_ACCESS_KEY'] = process.env.AWS_SECRET_ACCESS_KEY || '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'

module.exports = config[env]