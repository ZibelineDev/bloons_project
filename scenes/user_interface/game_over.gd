class_name GameOver extends Panel


static var is_over : bool = false


func _ready() -> void :
	
	visible = false
	
	Game.ref.game_over.connect(
		func(just_won : bool) -> void : 
			if not just_won : 
				visible = true
				is_over = true
	)
