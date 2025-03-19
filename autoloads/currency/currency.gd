class_name ACurrency extends Node


signal currency_created(new_value : int, quantity : int)
signal currency_consummed(new_value : int, quantity : int)
signal currency_refunded(new_value : int, quantity : int)
signal currency_updated(new_value : int)


var currency : int
var cheat_progress : int = 0
var cheat_interval : float = 0.0
var cheated : bool = false


func initialise() -> void :
	currency = 650
	cheated = false
	
	currency_updated.emit(currency)


func _process(delta : float) -> void : 
	if cheat_progress >= 1 :
		cheat_interval -= delta
		if cheat_interval <= 0.0 : 
			cheat_progress = 0
		if cheat_progress >= 3 :
			cheat_progress = 0
			cheat()


func _input(event : InputEvent) -> void :
	if event.is_action_pressed("stats") : 
		cheat_progress += 1 
		cheat_interval = 0.75


func cheat() -> void : 
	if not cheated : 
		create_currency(350 + 4000)
		cheated = true


func create_currency(quantity : int) -> void : 
	currency += quantity
	
	currency_created.emit(currency, quantity)
	currency_updated.emit(currency)
	(Stats as AStats).currency_earned += quantity


func refund_currency(quantity : int) -> void : 
	currency += quantity
	
	currency_refunded.emit(currency, quantity)
	currency_updated.emit(currency)


func consume_currency(quantity : int) -> Error : 
	if quantity > currency : return FAILED
	
	currency -= quantity
	currency_consummed.emit(currency, quantity)
	currency_updated.emit(currency)
	
	return OK
