class_name Confetti extends Control


static var ref : Confetti


func _init() -> void : ref = self


func play() -> void : 
	($BottomRight as GPUParticles2D).emitting = true
	($BottomRight as GPUParticles2D).restart()
	Sounds.play_ui_sound(Sounds.UISounds.POP)
	await get_tree().create_timer(0.2).timeout
	($BottomLeft as GPUParticles2D).emitting = true
	($BottomLeft as GPUParticles2D).restart()
	Sounds.play_ui_sound(Sounds.UISounds.POP)
	await get_tree().create_timer(0.5).timeout
	($BottomRight2 as GPUParticles2D).emitting = true
	($BottomRight2 as GPUParticles2D).restart()
	Sounds.play_ui_sound(Sounds.UISounds.POP)
	await get_tree().create_timer(0.5).timeout
	($BottomLeft2 as GPUParticles2D).emitting = true
	($BottomLeft2 as GPUParticles2D).restart()
	Sounds.play_ui_sound(Sounds.UISounds.POP)
	await get_tree().create_timer(1).timeout
	play()
