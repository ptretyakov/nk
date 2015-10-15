define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.html'

	Marionette.ItemView.extend
		debug		: true
		template 	: Template

		ui 	:
			'linkRegistration'	: '.js-link-registration'
			'linkLogin'			: '.js-link-login'

		events 		: 
			'click @ui.linkLogin'	: 'showLogin'

		showLogin	: ->
			console.log 'views/parts/header/header.showLogin : debug'