class_name BalloonArea2D extends Area2D


@onready var balloon : Balloon = get_parent()


func get_progress_ratio() -> float :
	return balloon.progress_ratio


func hit() -> void : 
	print("Balloon popped")
	balloon.pop()
