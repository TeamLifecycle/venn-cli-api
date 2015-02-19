homeController = {}
Nightmare = require 'nightmare'
fs = require 'fs'

homeController.index = (req, res) ->
	return res.sendStatus 200

homeController.mixpanel = (req, res) ->

	project = req.body.project
	username = req.body.username
	password = req.body.password

	result = undefined

	(new Nightmare)
	.goto('https://mixpanel.com/login/')
	# .wait(3000)
		.type('input#id_email', username)
		.type('input#id_password', password)
	.click('input[type="submit"]')
	.wait(3000)
	# ensure login successful
	.evaluate((->
		document.querySelectorAll('.select_button').length
	), (exists) ->
		unless exists
			unless result
				result = 
					status: 400
					data:
						"error": "Invalid credentials"
	)
	.click('.select_button')
		.wait(3000)
		.type('#id_name', project)
	.click('input#create_submit[type="submit"]')
		.wait(3000)
	# ensure project not already created
	# TODO ensure this evaluates fully before evaluate below it
	.evaluate((->
		document.querySelectorAll('.window_wrap .top_section').length
	), (windows) ->
		unless result
			if windows > 1
				result = {
					status: 400
					data:
						"error": "Error: Project '#{project}' already created"
				}
	)
	# get token
	.evaluate((->
		document.querySelector('#settings_modal .sm_content.management > div:nth-child(6) div.value').innerText
	), (token) ->
		unless result
			token = token.trim() if token
			if token
				result =
					status: 200
					data:
						keys:
							name: "MIXPANEL"
							value:
								TOKEN: token
						"install-cmd": "npm install mixpanel --save"

	)
	.run( ->
		return res.status(result.status).send(result.data) if result
		return res.status(500).send({error: "Something went wrong :("})
	)


# homeController.stripe = (req, res) ->
# 	new Nightmare(
# 		timeout: 20000
# 	)
# 	.goto('https://dashboard.stripe.com/login')
# 		.type('input#email', 'tim@getvenn.io')
# 		.type('input#password', 'orange13')
# 		.screenshot('test/test-stripe-before-login.png')
# 	.click('button[type=submit]')
# 		.wait(10000)
# 	# .goto('https://dashboard.stripe.com/test/dashboard')
# 		# .wait(10000)
# 		.screenshot('test/test-stripe-after-login-1.png')
# 	# .goto('https://dashboard.stripe.com/account/apikeys')
# 	.goto('https://stripe.com/docs/api#authentication')
# 		.wait(10000)
# 		.screenshot('test/test-stripe-after-login-2.png')
# 	# .evaluate((->
# 	# 	document.querySelector('html')
# 	# ), (title) ->
# 	# 	# console.log "title"
# 	# 	# console.log title
# 	# 	fs.writeFile "test.html", JSON.stringify(title)
# 	# ).screenshot('test/test-stripe-after-login-3.png')
# 	.run(->
# 		return res.sendStatus 201
# 	)

# homeController.dropbox = (req, res) ->
# 	new Nightmare(
# 	)
# 	.goto('https://www.dropbox.com/login')
# 	.type('input[name="login_email"]', 'testvenn@gmail.com')
# 	.type('input[name="login_password"]', 'Password321')
# 	.wait()
# 	.click('button.login-button[type=submit]')
# 	.wait(6000) #TODO not sure how long this needs to be
# 	.screenshot('test/test-dropbox-after-login.png')
# 	.run(->
# 		return res.sendStatus 201
# 	)

# homeController.ants = (req, res) ->
# 	(new Nightmare)
# 	.goto('http://antsmarching.org/forum/forumdisplay.php?f=11')
# 	.type('input.bginput#navbar_username', 'timmyg013')
# 	.type('input.bginput#navbar_password', 'orange13')
# 	.screenshot('test/ants-before-login.png')
# 	.click('input.button[type="submit"][value="Log in"]')
# 	.wait()
# 	.goto('http://antsmarching.org/forum/forumdisplay.php?f=11')
# 	.screenshot('test/ants-after-login-1.png')
# 	.wait()
# 	.screenshot('test/ants-after-login-2.png')
# 	.run(->
# 		return res.sendStatus 201
# 	)

module.exports = homeController
