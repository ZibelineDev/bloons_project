extends TextureRect


func _ready() -> void :
	if not SSS.activated : 
		visible = true
		var tween : Tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 5.0).set_trans(Tween.TRANS_CIRC)
		await tween.finished
		visible = false
	else : 
		visible = false
