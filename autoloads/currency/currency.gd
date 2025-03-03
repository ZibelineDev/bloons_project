class_name ACurrency extends Node


signal currency_created(new_value : int, quantity : int)
signal currency_consummed(new_value : int, quantity : int)
signal currency_updated(new_value : int)


var currency : int


func initialise() -> void :
	currency = 20
	
	currency_updated.emit(currency)


func create_currency(quantity : int) -> void : 
	currency += quantity
	
	currency_created.emit(currency, quantity)
	currency_updated.emit(currency)


func consume_currency(quantity : int) -> Error : 
	if quantity > currency : return FAILED
	
	currency -= quantity
	currency_consummed.emit(currency, quantity)
	currency_updated.emit(currency)
	
	return OK
