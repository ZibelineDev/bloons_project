class_name RTurret extends Resource


@export var type : Turret.Types = Turret.Types.DART
@export var name : String = "🎈 Please Rename Me"
@export var cost : int = 250
@export var cooldown : float = 0.5
@export var cooldown_progress : float = 0.0
@export var turret_range : float = 250.0
@export_multiline var description : String = "Oopsie, no description yet 🤷"


var first_upgrade_purchased : bool = false
var second_upgrade_purchased : bool = false


func get_speed_text() -> String : 
	if cooldown <= 0.1 : 
		return "Hypersonic"
	if cooldown <= 0.8 : 
		return "Fast"
	if cooldown <= 1.0 : 
		return "Normal"
	return "Slow"


func get_range_text() -> String :
	if turret_range >= 350.0 : 
		"Very Long"
	if turret_range >= 200.0 :
		return "Long"
	if turret_range >= 150.0 : 
		return "Medium"
	return "Short"
