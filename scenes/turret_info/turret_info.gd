class_name TurretInfo extends VBoxContainer

static var ref : TurretInfo

func _init() -> void : 
	ref = self 


@onready var turret_name: Label = %TurretName
@onready var range_value: Label = %RangeValue
@onready var upgrade_1: Button = %Upgrade1
@onready var upgrade_2: Button = %Upgrade2


func _ready() -> void :
	pass


func select() -> void : 
	visible = true


func deselect() -> void : 
	visible = false
