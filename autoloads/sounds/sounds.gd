class_name ASounds extends Node


enum UISounds {
	SWITCH,
	BONG,
	CLICK,
	CONFIRMATION,
	AUGMENT_CHOICE,
	AUGMENT_PICK,
	VICTORY,
	WAVE_COMPLETE,
	POP,
}


@export var muted : bool = false


@onready var pew_pew: AudioStreamPlayer = %PewPew
@onready var bonk: AudioStreamPlayer = %Bonk
@onready var pop: AudioStreamPlayer = %Pop
@onready var ice_tower: AudioStreamPlayer = %IceTower
@onready var missile_tower: AudioStreamPlayer = %MissileTower
@onready var ui: AudioStreamPlayer = %UI
@onready var victory: AudioStreamPlayer = %Victory


func play_pew_pew() -> void :
	if muted : return 
	pew_pew.play()


func play_bonk() -> void : 
	if muted : return
	bonk.pitch_scale = randf_range(0.9, 1.1)
	bonk.play()


func play_pop() -> void : 
	if muted : return
	pop.pitch_scale = randf_range(0.9, 1.1)
	pop.play()


func play_victory() -> void : 
	victory.play()


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
		UISounds.AUGMENT_CHOICE : ui.stream = preload("uid://bot73fwrsm8ku")
		UISounds.AUGMENT_PICK : ui.stream = preload("uid://cs4frf1sarflb")
		UISounds.VICTORY : ui.stream = preload("uid://cgdc2tfbtsu5s")
		UISounds.WAVE_COMPLETE : ui.stream = preload("uid://b0lcj0dpn2h5j")
		UISounds.POP : ui.stream = preload("uid://fn7ag2g7ji1w")
		
	
	ui.play()
