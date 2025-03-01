class_name BalloonPath extends Path2D


func _ready() -> void :
	spawn_wave_01()


func spawn_wave_01() -> void : 
	var timer : float = 0.2
	
	for index : int in range(40) : 
		add_child(Balloon.create())
		timer = randf_range(0.05, 0.2)
		await get_tree().create_timer(timer).timeout
