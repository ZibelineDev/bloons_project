class_name LivesLabel extends Label


func _ready() -> void :
	Game.ref.lives_updated.connect(on_lives_updated)


func on_lives_updated(new_value : int) -> void : 
	text = "Lives : %s" %new_value
