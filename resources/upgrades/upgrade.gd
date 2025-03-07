class_name RUpgrade extends Resource


enum List {
	DART_PIERCE,
	DART_RANGE,
	TACK_SPEED,
	TACK_RANGE,
}


static var upgrades : Dictionary[List, RUpgrade] = {
	List.DART_PIERCE : load("uid://dlhrk1d2spcx2"),
	List.DART_RANGE : load("uid://cs3a0dadhls8h"),
	List.TACK_SPEED : load("uid://bn2et1joi2ftm"),
	List.TACK_RANGE : load("uid://duvdt0gxlpkjn"),
}


@export var name : String = "⬆️ I havn't been renamed, blame the devs !"
@export var cost : int = 0
@export var texture : Texture2D
