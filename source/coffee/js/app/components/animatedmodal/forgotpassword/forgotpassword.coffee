define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	AnimatedModal 	= require 'components/animatedmodal/animatedmodal'

	FrontView 		= Marionette.ItemView.extend
		template : 'Front view <a href="#" class="js-animate-modal-rotate">Перевернуть</a>'

	BackView 		= Marionette.ItemView.extend
		template : 'Back view <a href="#" class="js-animate-modal-rotate">Перевернуть</a>'

	ComponentItem = Marionette.ItemView.extend
		template : "Type component template"

	AnimatedModal.extend
		title		: 'Забыли пароль?'
		
		frontView 	: new FrontView()
		backView 	: new BackView()

		# Если нужен только перед
		# bodyView	: new ComponentItem()