class_name CurrencyLabel extends Label


func _ready() -> void :
	(Currency as ACurrency).currency_updated.connect(on_currency_created)


func on_currency_created(new_value : int) -> void :
	text = "Money : %s" %new_value
