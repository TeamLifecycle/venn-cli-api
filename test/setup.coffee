# TODO these shouldn't be global
# even though just used for test suite

mongoose = require "mongoose"
# TODO this should know which environment you are
mongoose.connect "mongodb://localhost/api-development"