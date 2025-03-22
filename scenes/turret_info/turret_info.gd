class_name TurretInfo extends VBoxContainer

static var ref : TurretInfo

func _init() -> void : 
	ref = self 


@onready var turret_name: Label = %TurretName
@onready var range_value: Label = %RangeValue
@onready var speed_value: Label = %SpeedValue
@onready var upgrade_1: UpgradeInfo = %Upgrade1
@onready var upgrade_2: UpgradeInfo = %Upgrade2

var turret : Turret 


func _ready() -> void :
	upgrade_1.pressed.connect(on_button_1_pressed)
	upgrade_2.pressed.connect(on_button_2_pressed)
	(%SellButton as Button).pressed.connect(on_sell_pressed)
	visible = false
	
	UserInterface.ref.upgrade_purchased.connect(
		func() -> void :
			update_values()
	)


func select(_turret : Turret) -> void : 
	turret = _turret
	turret_name.text = turret.resource.name
	upgrade_1.inject_resource(turret.get_first_upgrade(), turret.resource, 1)
	upgrade_2.inject_resource(turret.get_second_upgrade(), turret.resource, 2)
	update_values()
	visible = true
	
	if turret.resource.type == Turret.Types.HYPERSONIC : 
		(upgrade_2.get_parent() as Control).visible = false
	else : 
		(upgrade_2.get_parent() as Control).visible = true


func deselect() -> void : 
	turret = null
	visible = false


func update_values() -> void : 
	range_value.text = turret.resource.get_range_text()
	speed_value.text = turret.resource.get_speed_text()


func on_button_1_pressed() -> void : 
	turret.try_to_purchase_first_upgrade()


func on_button_2_pressed() -> void : 
	turret.try_to_purchase_second_upgrade()


func on_sell_pressed() -> void : 
	turret.sell()
