# request = require "request"

it "birds should fly", ->
	1.should.equal 1

it 'should respond with a 200', (done) ->
	request.get
		url: "http://localhost:3000/v1"
	, (error, response, body) ->
		response.statusCode.should.equal 200
		done()		