class_name ASounds extends Node


@export var muted : bool = false


@onready var pew_pew: AudioStreamPlayer = %PewPew
@onready var bonk: AudioStreamPlayer = %Bonk


func play_pew_pew() -> void :
	if muted : return 
	pew_pew.play()


func play_bonk() -> void : 
	if muted : return
	bonk.play()
