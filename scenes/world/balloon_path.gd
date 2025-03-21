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


var augment_waves : Array[int] = [
	4, 8, 12, 16, 20, 24, 28, 32, 36, 40 , 44, 48
]

var waves : Array[String] = [
	"uid://cvurd1in1rif5", #1
	"uid://c73bse16djgvv",
	"uid://d3ntbm64xcioq",
	"uid://gainer3dvx6r",
	"uid://j5ugsxn87kej", #5
	"uid://jlfwawf2pps1",
	"uid://ccxa2s5t5op5x",
	"uid://svtmvpeigoxy",
	"uid://deakjp3fo1s57",
	"uid://krbay3jg0fym", #10
	"uid://6la7d4sbq6tr",
	"uid://b6dnfeqbe12hw",
	"uid://cddr1sbcn6j7p",
	"uid://d3ken4bgo34lx",
	"uid://cshj721d7sfu7", #15
	"uid://djt55vnod5fq0",
	"uid://bmjwcbrtcds4m",
	"uid://dfx0df6mpb0en",
	"uid://dhunarqtemt1d",
	"uid://qwoty61fgnpb", #20
	"uid://46c2smotplx0",
	"uid://8phar7vhvnkf",
	"uid://bain5ypfqo1ik",
	"uid://fuqy8r4js1uo",
	"uid://bft842jh4ch1n", #25
	"uid://crb0onc5u1bi2",
	"uid://cwysxlmuyf2o0",
	"uid://7jvarp1lldb1",
	"uid://7uwdfjqcxydv",
	"uid://pixc8wsyor1p", #30
	"uid://1smtwyj2w0ki", 
	"uid://battjcx36f4wq",
	"uid://cjaln0gxcm8qy",
	"uid://ldreweqvch53", 
	"uid://ctmj3wjuajiiu", #35
	"uid://3b2anclxt121",
	"uid://fdamhnyr8gdw",
	"uid://belxgeyj102lp",
	"uid://ce4edu4r7sai6",
	"uid://y037krecqdgb", #40
	"uid://d2yiebwn4sd7m",
	"uid://dpxheevie4awb",
	"uid://cpa6b2oepb2eb",
	"uid://cx6f1tfi4gug1",
	"uid://bq0n8mnb7878p", #45
	"uid://ursjieyheokm", 
	"uid://cm0fxylldsgqw",
	"uid://cbv2sjgr2x1tr",
	"uid://c0je0n4w4d1p3",
	"uid://bpna4we5vs83d", #50
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
	spawn_timer.wait_time = wave_resource.spawn_interval
	spawn_timer.start()
	(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CONFIRMATION)


func close_wave() -> void : 
	if not wave_active : return
	if completed_waves == 49 : 
		completed_waves += 1
		wave_completed.emit(completed_waves)
		Game.ref.game_over_func(true)
		return
	
	wave_active = false
	(Currency as ACurrency).create_currency(100 - completed_waves)
	var feedback : String = ""
	feedback += "Reward : + %s Money." %(100 - completed_waves)
	feedback += " %s" %wave_resource.flavour_text
	UserInterface.ref.create_feedback(feedback)
	completed_waves += 1
	wave_completed.emit(completed_waves)
	
	if augment_waves.has(completed_waves) :
		AugmentCardChoice.ref.initialise_choice()


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
