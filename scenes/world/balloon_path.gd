class_name Waves extends Path2D

static var ref : Waves 

func _init() -> void : 
	ref = self


signal wave_initiated(wave_index : int)
signal wave_completed(completed_waves : int)


var completed_waves : int
var wave_active : bool

var spawn_completed : bool


var waves : Array[Callable] = [
	spawn_wave_01,
	spawn_wave_02,
	spawn_wave_03,
]


func _physics_process(_delta : float) -> void :
	if wave_active and spawn_completed : 
		if get_child_count() == 0 :
			close_wave()


func initialise() -> void : 
	completed_waves = 0
	wave_active = false
	wave_completed.emit(completed_waves)


func initiate_wave() -> void :
	if wave_active : return
	
	wave_active = true
	spawn_completed = false
	waves[completed_waves].call()
	wave_initiated.emit(completed_waves + 1)


func close_wave() -> void : 
	if not wave_active : return
	
	wave_active = false
	(Currency as ACurrency).create_currency(100 - completed_waves)
	UserInterface.ref.create_feedback("Wave Completed. %s currency have ben awarded." %(100 - completed_waves))
	completed_waves += 1
	wave_completed.emit(completed_waves)


func spawn_wave_01() -> void : 
	var timer : float = 0.2
	
	for index : int in range(12) : 
		add_child(Balloon.create())
		await get_tree().create_timer(timer).timeout
	
	spawn_completed = true


func spawn_wave_02() -> void : 
	var timer : float = 0.2
	
	for index : int in range(25) : 
		add_child(Balloon.create())
		await get_tree().create_timer(timer).timeout
	
	spawn_completed = true


func spawn_wave_03() -> void : 
	var timer : float = 0.2
	
	for index : int in range(24) : 
		add_child(Balloon.create())
		await get_tree().create_timer(timer).timeout
	
	for index : int in range(5) : 
		add_child(Balloon.create(1))
		await get_tree().create_timer(timer).timeout
	
	spawn_completed = true
