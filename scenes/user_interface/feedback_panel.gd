extends MarginContainer


func _ready() -> void :
	(%FeedbackClick as Button).pressed.connect(
		func() -> void : 
			visible = false
			(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)
	)
