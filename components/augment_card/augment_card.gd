class_name AugmentCard extends Control


signal purchased(augment : RAugment)

@onready var veil: Panel = %Veil

var hovered : bool = false
var augment : RAugment


func _ready() -> void :
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)


func _input(event : InputEvent) -> void :
	if not hovered : return
	
	if event.is_action_pressed("left_click") : 
		purchased.emit(augment)


func inject_resource(new_augment : RAugment) -> void : 
	augment = new_augment
	(%Header as Label).text = augment.name
	(%TextureRect as TextureRect).texture = load(augment.texture_path)
	(%Description as Label).text = augment.description


func on_mouse_entered() -> void : 
	veil.visible = true
	hovered = true


func on_mouse_exited() -> void : 
	veil.visible = false
	hovered = false
