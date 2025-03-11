class_name UpgradeInfo extends Button


@onready var texture_rect: TextureRect = %TextureRect
@onready var upgrade_name: Label = %UpgradeName
@onready var status: Label = %Status
@onready var cost: Label = %Cost


var resource : RUpgrade
var turret : RTurret
var index : int 


func _ready() -> void :
	Currency.currency_updated.connect(on_currency_updated)
	UserInterface.ref.upgrade_purchased.connect(on_upgrade_purchased)


func inject_resource(new_resource : RUpgrade, new_turret : RTurret, new_index : int) -> void : 
	resource = new_resource 
	turret = new_turret
	index = new_index
	texture_rect.texture = resource.texture
	upgrade_name.text = resource.name
	cost.text = str(resource.cost)
	
	update_status()


func update_status() -> void :
	if not resource : return
	
	match index : 
		1 : 
			if turret.first_upgrade_purchased : 
				status.text = "Purchased"
				return
			if Currency.currency >= resource.cost :
				status.text = "Buy for:"
			else : 
				status.text = "Can't afford"
		2 :
			if turret.second_upgrade_purchased : 
				status.text = "Purchased"
				return
			if Currency.currency >= resource.cost :
				status.text = "Buy for:"
			else : 
				status.text = "Can't afford"


func on_currency_updated(_new_value : int) -> void : 
	update_status()


func on_upgrade_purchased() -> void : 
	update_status()
