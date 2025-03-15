class_name VolumeSlider extends HSlider


func _ready() -> void :
	value_changed.connect(
		func(new_value : float) -> void : 
			AudioServer.set_bus_volume_linear(0, new_value)
	)
	
