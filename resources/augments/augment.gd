class_name RAugment extends Resource


enum Types {
	DEBUG,
	GREED,
	MINOR_RANGE,
	DART_ATTACK_SPEED,
	BIGGER_DARTS,
	PIERCING_DARTS,
	MINOR_CHAIN,
}


static var dictionary : Dictionary[Types, String] = {
	Types.GREED : "uid://e27agvnn820r",
	Types.MINOR_RANGE : "uid://dunsusjdki3yc",
	Types.DART_ATTACK_SPEED : "uid://blc8j7ky0ll3h",
	Types.BIGGER_DARTS : "uid://d0uywkfut6rhy",
	Types.PIERCING_DARTS : "uid://b4ljwy17ufc6m",
	Types.MINOR_CHAIN : "uid://djni8h5y2kltb",
}


@export var key : Types = Types.DEBUG
@export var name : String = "Debug Augment"
@export var texture_path : String = ""
@export var description : String = "No Description"
