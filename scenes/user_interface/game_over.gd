extends Panel


func _ready() -> void :
	
	visible = false
	
	Game.ref.game_over.connect(
		func() -> void : 
			visible = true
	)
