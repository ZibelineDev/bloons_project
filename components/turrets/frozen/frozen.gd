class_name FrozenTurret extends Turret


static var this_scene : String = "uid://bnwrwblkx6wm4"
static var this_resource : String = "uid://bah20vq8ns2mr"


@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D

var duration : float = 1.2
var area_animation : Tween


func _ready() -> void :
	super()
	area_animation = get_tree().create_tween()
	area_animation.tween_property(%TextureIndicator, "modulate:a", 1.0, 0.2)
	area_animation.tween_property(%TextureIndicator, "modulate:a", 0.0, 0.8).set_trans(Tween.TRANS_CIRC)
	area_animation.finished.connect(func() -> void : area_animation.stop())
	area_animation.stop()
	(%TextureIndicator as TextureRect).modulate.a = 0.0


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(_target : Balloon) -> void :
	var balloons : Array[Area2D] = (%RangeArea as Area2D).get_overlapping_areas()
	for balloon_area : BalloonArea2D in balloons : 
		balloon_area.balloon.freeze(duration)
	gpu_particles_2d.emitting = true
	area_animation.play()
	(Sounds as ASounds).play_ice_tower()


func update_range() -> void : 
	super()
	@warning_ignore("shadowed_variable")
	var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
	(gpu_particles_2d.process_material as ParticleProcessMaterial).emission_sphere_radius = resource.turret_range
	var texture_rect : TextureRect = %TextureIndicator
	texture_rect.size = 2 * Vector2(resource.turret_range, resource.turret_range)
	texture_rect.position = -Vector2(resource.turret_range, resource.turret_range)


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.FROZEN_TIME]


func apply_first_upgrade() -> void : 
	super()
	duration += 0.55


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.FROZEN_RANGE]


func apply_second_upgrade() -> void : 
	super()
	resource.turret_range += 25.0
	update_range()
