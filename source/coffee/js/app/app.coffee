define (require) ->
	'use strict'

	Marionette = require 'marionette'
	Routes     = require 'app/routes'
	Desktop    = require 'controllers/desktop'
	Handlebars = require 'handlebars'

	require 'system/helpers'
	require 'rivets'
	require 'backbone.rivets'

	app =new Marionette.Application
		debug	: true

		regions :
			regionContent	: '#region-content'

		initialize : ->
			console.log 'app/app : initializing app' if @debug				

		preload	: ->
			console.log 'app/app : preload function ' if @debug

			@appRouter = new Routes controller : new Desktop()
			Backbone.history.start()

		Rivets : rivets

	app.addInitializer ( options ) -> return @preload()

	app.regionContent.on 'show' , ->
		console.log 'TEeeeeeeest'
		removeClass app.regionContent.el , 'fadeout'
		addClass app.regionContent.el , 'fadein'


	Marionette.Behaviors.behaviorsLookup = -> return window.Behaviors

	Marionette.Renderer.render = ( template , data ) ->
		toHTML = Handlebars.compile template
		return toHTML data

	return app