{Article, request} = require '../vars'

it "birds should fly", ->
	1.should.equal 1

describe 'requesting root page', ->

	it 'should respond with a 200', (done) ->
		request.get
			url: "http://localhost:3000/v1"
		, (error, response, body) ->
			response.statusCode.should.equal 200
			done()


describe 'ensuring database working', ->

	it 'test should respond with a 200', (done) ->
		# this is created in before.coffee
		# and destroyed in after.coffee
		Article.findOne
			title: "Testy Mctesterson"
		, (err, article) ->
			article.should.exist
			done()