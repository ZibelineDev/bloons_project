class_name BalloonBody extends CharacterBody2D


@onready var balloon : Balloon = get_parent()


func _physics_process(_delta : float) -> void :
	move_and_slide()


func get_progress_ratio() -> float :
	return balloon.progress_ratio


func hit() -> void : 
	print("Balloon popped")
	balloon.pop()
