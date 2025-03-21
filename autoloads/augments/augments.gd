class_name AAugment extends Node


signal augment_purchased(augment : RAugment)


var purchased_augments : Array[RAugment] = []
var augment_pool : Array[RAugment] = []


func initialise() -> void : 
	augment_pool.clear()
	augment_pool.append(load("uid://e27agvnn820r")) #Greed
	augment_pool.append(load("uid://e27agvnn820r")) #Greed
	augment_pool.append(load("uid://dunsusjdki3yc")) #Minor Range
	augment_pool.append(load("uid://dunsusjdki3yc")) #Minor Range
	augment_pool.append(load("uid://blc8j7ky0ll3h")) #Dart Speed
	augment_pool.append(load("uid://blc8j7ky0ll3h")) #Dart Speed
	augment_pool.append(load("uid://d0uywkfut6rhy")) #Bigger Darts
	augment_pool.append(load("uid://d0uywkfut6rhy")) #Bigger Darts
	augment_pool.append(load("uid://b4ljwy17ufc6m")) #Piercing Darts
	augment_pool.append(load("uid://b4ljwy17ufc6m")) #Piercing Darts
	augment_pool.append(load("uid://djni8h5y2kltb")) #Minor Chain
	augment_pool.append(load("uid://m6k8gpobd0ps")) #Minor Frost
	augment_pool.append(load("uid://mu8m2e13qmg7")) #Guaranteed Shot
	augment_pool.append(load("uid://cgmmagi67d46q")) #Money
	augment_pool.append(load("uid://cgmmagi67d46q")) #Money
	augment_pool.append(load("uid://cgmmagi67d46q")) #Money
	augment_pool.append(load("uid://cgmmagi67d46q")) #Money
	augment_pool.append(load("uid://bjde1k0cwn6h")) #Med Pack
	augment_pool.append(load("uid://bjde1k0cwn6h")) #Med Pack
	augment_pool.append(load("uid://bjde1k0cwn6h")) #Med Pack
	augment_pool.append(load("uid://bjde1k0cwn6h")) #Med Pack


func purchase_augment(augment : RAugment) -> void : 
	purchased_augments.append(augment)
	augment_pool.erase(augment)
	augment_purchased.emit(augment)
	
	if augment == load("uid://mu8m2e13qmg7") : 
		Bullet.guaranteed_shot_magnitude += 1
	
	if augment == load("uid://bjde1k0cwn6h") : 
		Game.ref.lose_life(-10)
	
	if augment == load("uid://cgmmagi67d46q") : 
		Currency.create_currency(500)



func get_augment(augment : RAugment) -> int : 
	return purchased_augments.count(augment)


func pick_random_augment() -> RAugment : 
	var augment : RAugment = augment_pool.pick_random()
	return augment
