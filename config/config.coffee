path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'api2'
    port: 3000
    db: 'mongodb://localhost/api2-development'

  test:
    root: rootPath
    app:
      name: 'api2'
    port: 3000
    db: 'mongodb://localhost/api2-test'

  production:
    root: rootPath
    app:
      name: 'api2'
    port: 3000
    db: 'mongodb://localhost/api2-production'

module.exports = config[env]
