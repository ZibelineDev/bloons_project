class_name ASounds extends Node


@export var muted : bool = false


@onready var pew_pew: AudioStreamPlayer = %PewPew
@onready var bonk: AudioStreamPlayer = %Bonk
@onready var pop: AudioStreamPlayer = %Pop


func play_pew_pew() -> void :
	if muted : return 
	pew_pew.play()


func play_bonk() -> void : 
	if muted : return
	bonk.play()


func play_pop() -> void : 
	if muted : return
	pop.pitch_scale = randf_range(0.9, 1.1)
	pop.play()
	
