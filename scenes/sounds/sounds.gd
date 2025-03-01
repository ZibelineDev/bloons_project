class_name ASounds extends Node


@onready var pew_pew: AudioStreamPlayer = %PewPew
@onready var bonk: AudioStreamPlayer = %Bonk


func play_pew_pew() -> void : 
	pew_pew.play()


func play_bonk() -> void : 
	bonk.play()
