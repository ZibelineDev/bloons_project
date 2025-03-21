class_name VictoryPanel extends Panel


static var is_over : bool = false

func _ready() -> void :
	
	visible = false
	
	Game.ref.game_over.connect(
		func(just_won : bool) -> void : 
			if just_won : 
				Sounds.play_ui_sound(Sounds.UISounds.VICTORY)
				visible = true
				is_over = true
	)
