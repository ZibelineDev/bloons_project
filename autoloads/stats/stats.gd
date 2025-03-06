class_name AStats extends Node


var currency_earned : int = 0
var currency_spent_on_turret : int = 0
var currency_spent_on_upgrades : int = 0


func _input(event : InputEvent) -> void :
	if event.is_action_pressed("stats") : 
		print_rich("Currency Earned : %s" %currency_earned)


func on_currency_created(_new_value : int, quantity : int) -> void : 
	currency_earned += quantity
