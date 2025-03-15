class_name ASounds extends Node


enum UISounds {
	SWITCH,
	BONG,
	CLICK,
	CONFIRMATION,
}


@export var muted : bool = false


@onready var pew_pew: AudioStreamPlayer = %PewPew
@onready var bonk: AudioStreamPlayer = %Bonk
@onready var pop: AudioStreamPlayer = %Pop
@onready var ice_tower: AudioStreamPlayer = %IceTower
@onready var missile_tower: AudioStreamPlayer = %MissileTower
@onready var ui: AudioStreamPlayer = %UI


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


func play_ice_tower() -> void : 
	ice_tower.play()


func play_missile() -> void : 
	missile_tower.play()


func play_ui_sound(ui_sound : UISounds) -> void : 
	match ui_sound : 
		UISounds.SWITCH : ui.stream = preload("uid://b4cdh75uyifb1")
		UISounds.BONG : ui.stream = preload("uid://cufsoedewgyv2")
		UISounds.CLICK : ui.stream = preload("uid://bjteg3mtddssj")
		UISounds.CONFIRMATION : ui.stream = preload("uid://dpfcyf20r6b88")
	
	ui.play()
