extends Button


func _ready() -> void :
	pressed.connect(
		func() -> void : 
			print("Hey")
			Game.ref.reset()
	)
