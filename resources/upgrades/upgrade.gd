class_name RUpgrade extends Resource


enum List {
	DART_RANGE,
}


static var upgrades : Dictionary[List, RUpgrade] = {
	List.DART_RANGE : load("uid://cs3a0dadhls8h"),
}


@export var name : String = "⬆️ I havn't been renamed, blame the devs !"
@export var cost : int = 0
@export var texture : Texture2D
