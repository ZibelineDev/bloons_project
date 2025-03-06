class_name TurretShopIcon extends TextureButton


@export var type : Turret.Types
@export var texture : Texture2D
@export var label : String = ""


func _ready() -> void :
	pressed.connect(on_pressed)
	($Label as Label).text = label
	texture_normal = texture


func on_pressed() -> void : 
	UserInterface.ref.create_turret_pressed.emit(type)
