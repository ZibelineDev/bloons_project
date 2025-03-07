class_name TurretInfo extends VBoxContainer

static var ref : TurretInfo

func _init() -> void : 
	ref = self 


@onready var turret_name: Label = %TurretName
@onready var range_value: Label = %RangeValue
@onready var upgrade_1: Button = %Upgrade1
@onready var upgrade_2: Button = %Upgrade2

var turret : Turret 


func _ready() -> void :
	upgrade_1.pressed.connect(on_button_1_pressed)
	upgrade_2.pressed.connect(on_button_2_pressed)
	visible = false


func select(_turret : Turret) -> void : 
	turret = _turret
	var _upgrade_1 : RUpgrade = turret.get_first_upgrade()
	upgrade_1.text = "%s\n%s" %[_upgrade_1.name, _upgrade_1.cost]
	var _upgrade_2 : RUpgrade = turret.get_second_upgrade()
	upgrade_2.text = "%s\n%s" %[_upgrade_2.name, _upgrade_2.cost]
	visible = true


func deselect() -> void : 
	turret = null
	visible = false


func on_button_1_pressed() -> void : 
	turret.try_to_purchase_first_upgrade()


func on_button_2_pressed() -> void : 
	turret.try_to_purchase_second_upgrade()
