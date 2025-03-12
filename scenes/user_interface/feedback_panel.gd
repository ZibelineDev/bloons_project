extends MarginContainer


func _ready() -> void :
	(%FeedbackClick as Button).pressed.connect(
		func() -> void : 
			visible = false
	)
