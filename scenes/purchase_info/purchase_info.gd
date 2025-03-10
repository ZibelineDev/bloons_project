class_name PurchaseInfo extends VBoxContainer


@onready var turret_name: Label = %Name
@onready var cost_value: Label = %CostValue
@onready var speed_value: Label = %SpeedValue
@onready var description: RichTextLabel = %Description


var last_resource : RTurret


func inject_data(resource : RTurret) -> void :
	last_resource = resource
	 
	turret_name.text = resource.name
	cost_value.text = str(resource.cost)
	speed_value.text = resource.get_speed_text()
	description.text = resource.description
