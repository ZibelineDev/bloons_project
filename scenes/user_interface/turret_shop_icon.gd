class_name TurretShopIcon extends TextureButton


@onready var purchase_info: PurchaseInfo = %PurchaseInfo
@onready var turret_view: TabContainer = %TurretView


@export var type : Turret.Types
@export var texture : Texture2D
@export var label : String = ""


func _ready() -> void :
	pressed.connect(on_pressed)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	($Label as Label).text = label
	texture_normal = texture


func on_pressed() -> void : 
	UserInterface.ref.create_turret_pressed.emit(type)


func on_mouse_entered() -> void : 
	purchase_info.inject_data(Turret.turrets[type])
	turret_view.current_tab = 1


func on_mouse_exited() -> void : 
	if purchase_info.last_resource == Turret.turrets[type] : 
		turret_view.current_tab = 0
