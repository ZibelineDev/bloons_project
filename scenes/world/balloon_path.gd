class_name Waves extends Path2D

static var ref : Waves 

func _init() -> void : 
	ref = self


signal wave_initiated(wave_index : int)
signal wave_completed(completed_waves : int)


var completed_waves : int
var wave_active : bool
var wave_resource : RWave

var spawn_completed : bool

@onready var spawn_timer: Timer = %SpawnTimer


var waves : Array[String] = [
	"uid://cvurd1in1rif5",
	"uid://c73bse16djgvv",
	"uid://d3ntbm64xcioq",
	"uid://gainer3dvx6r",
	"uid://j5ugsxn87kej",
	"uid://jlfwawf2pps1",
]


func _ready() -> void :
	spawn_timer.timeout.connect(on_spawn_timer_timeout)


func _physics_process(_delta : float) -> void :
	if wave_active and spawn_completed : 
		if get_child_count() == 0 :
			close_wave()


func initialise() -> void : 
	completed_waves = 0
	wave_active = false
	wave_completed.emit(completed_waves)


func initiate_wave() -> void :
	if completed_waves >= waves.size() :
		UserInterface.ref.create_feedback("There are no More waves Yet. Be Patient (or don't and harass me on Discord)")
		return
	if wave_active : return
	
	wave_active = true
	spawn_completed = false
	wave_initiated.emit(completed_waves + 1)
	wave_resource = load(waves[completed_waves])
	spawn_timer.start()


func close_wave() -> void : 
	if not wave_active : return
	
	wave_active = false
	(Currency as ACurrency).create_currency(100 - completed_waves)
	UserInterface.ref.create_feedback("Wave Completed. %s currency have ben awarded." %(100 - completed_waves))
	completed_waves += 1
	wave_completed.emit(completed_waves)


func on_spawn_timer_timeout() -> void : 
	if wave_resource.content[0].y == 0 :
		wave_resource.content.pop_front()
	
	if wave_resource.content.size() <= 0 :
		spawn_completed = true
		spawn_timer.stop()
		return
	
	if wave_resource.content[0].x == -1 : 
		wave_resource.content[0].y -= 1
		return
	
	add_child(Balloon.create(wave_resource.content[0].x))
	wave_resource.content[0].y -= 1
