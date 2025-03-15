class_name GameOver extends Panel


static var is_over : bool = false


func _ready() -> void :
	
	visible = false
	
	Game.ref.game_over.connect(
		func() -> void : 
			visible = true
			is_over = true
	)
