define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/login/login.html'

	require 'gsap'
	require 'syphon'

	View = Marionette.ItemView.extend
		debugAnimation	: true
		debug 			: true
		template 		: Template

		ui :
			'link_registrateFromLogin'	: '.js-registrate-from-login'
			'link_loginFromRegistrate'	: '.js-login-from-registrate'

		events :
			'click @ui.link_registrateFromLogin'	: 	'showRegistrateFromLogin'
			'click @ui.link_loginFromRegistrate'	:	'showLoginFromRegistrate'
			'submit #login_form': 'doLogin'
			'submit #register_form': 'doRegister'


		initialize : ->
			@on 'showLoginFromHeader'	, @showLoginFromHeader , @
			@on 'showRegistrateFromHeader'	, @showRegistrateFromHeader , @
			@on 'hideLogin'	, @hideLogin , @
			@on 'render' 	, @afterRender , @

		afterRender : ->
			@sectionElement = @el.querySelectorAll 		'.autn-section'
			@registerSide 	= @el.querySelector 		'.registr-side'
			@loginSide 		= @el.querySelector 		'.login-side'
			@scaleElement	= document.getElementById 	'scale-body'	# Элемент который будет уходить назад
			@scaleClass		= 'scale-element' # Клас анимации ухода назад
			@authVisible	= false

			pause = =>
				@dropSectionFromSide.pause()

			CSSPlugin.defaultTransformPerspective = 0

			###*
			# ------------- Анимации выводит блок аутентификации -------------
			###
			#.set @el ,{ zIndex : 300  	, display : 'block' }
			#.to @scaleElement 	, .5 	, className : '+=' + @scaleClass , 0
			@dropSectionFromSide = new TimelineMax paused : true
				.add 'startAnimation'				
				.set @registerSide , rotationX : -180				
				.to @scaleElement 	, .3 	, className : '+=' + @scaleClass + ' background-color-overlay' , 0
				.to @sectionElement , .3 , { right : '0%' , alpha : 1 } , 0
				.addLabel 'backToLogin'
				.addLabel 'dropSection'
					.to @registerSide	, .5 	, rotationX : 0 	, .3
					.to @loginSide 		, .5 	, rotationX : 180 	, .3 # Анимация прокручивает секцию до регистраци
					.addLabel 'revertRegistr'

			### ___________ Анимация выводит формы регистрации ___________ ###
			@dropRegistrateFromHeader = new TimelineMax paused : true
				.add 'startAnimation'
				.set @registerSide , rotationX : -180
				.set @registerSide , rotationX 	: 0 , 'setRevertRegistr'
				.set @loginSide 	, rotationX : 180 , 'setRevertRegistr'
				.add app.tweens.scaleBody.play() , 'startAnimation'

				.to @sectionElement , .3 	, { right : '0%' , alpha : 1 } , 0
				.addLabel 'dropSection'

			window.test = @dropSectionFromSide

			# Прослушиваем клик вне логин формы
			@scaleElement.addEventListener 'click' , =>
				@controlReversedAnimations ->
					console.log 'scaleElement'

		controlReversedAnimations : ( callback ) ->
			control = false

			# Если анимация не активна и анимирована
			if @sectionDropped()
				console.log 'sectionDropped'
				if callback?
					@dropSectionFromSide.eventCallback 'onReverseComplete' , -> callback()
				#else
					#@dropSectionFromSide.eventCallback 'onReverseComplete' , -> return console.log 'Not callback? dropSectionFromSide'

				# Возвращаем обратно сексию авторизации/регистрации
				return @dropSectionFromSide.reverse()
				control = true

			if @registrateFromHeader()
				console.log 'registrateFromHeader'
				if callback?
					@dropRegistrateFromHeader.eventCallback 'onReverseComplete' , -> callback()
				#else
					#@dropRegistrateFromHeader.eventCallback 'onReverseComplete' , -> return console.log 'Not callback? dropRegistrateFromHeader'

				# Возвращаем поле регистрации за края страницы
				return @dropRegistrateFromHeader.reverse()
				control = true

			if not control and callback?
				console.log 'not Control and callback?'
				callback()


		# Проверяет состоияние сексции выдвинута ли она || анимация не активна и анимирована
		sectionDropped : ->
			return not @dropSectionFromSide.isActive() and @dropSectionFromSide.progress()

		registrateFromHeader : ->
			return not @dropRegistrateFromHeader.isActive() and @dropRegistrateFromHeader.progress()

		showRegistrateFromLogin		: ( event ) ->
			@dropSectionFromSide.tweenTo 'revertRegistr'
			event.preventDefault()

		showLoginFromRegistrate		: ( event ) ->
			@controlReversedAnimations =>
				@dropSectionFromSide.tweenFromTo 'revertRegistr' , 'dropSection'

			event.preventDefault()

		### From Header ###
		showRegistrateFromHeader	: ( event ) ->
			@controlReversedAnimations =>
				@dropRegistrateFromHeader.tweenFromTo 'startAnimation' , 'dropSection'

		showLoginFromHeader			: ( event ) ->
			@controlReversedAnimations =>
				@dropSectionFromSide.tweenFromTo 'startAnimation' , 'backToLogin'
		doLogin : ( event ) ->
			event.preventDefault()
			data = Backbone.Syphon.serialize(this);
			$.post 'http://localhost:3000' + '/api/v1/auth/sessions.json', data, (result) =>
				console.log "result login: ", result
			console.log 'do login', data
		doRegister : ( event ) ->
			event.preventDefault()
			data = Backbone.Syphon.serialize(this);
			$.post 'http://localhost:3000' + '/api/v1/auth/registrations.json', data, (result) =>
				console.log "result register: ", result
			console.log 'do register', data
	return View
