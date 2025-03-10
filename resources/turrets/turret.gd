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
	return "duh"


func get_range_text() -> String :
	return "duuh"
