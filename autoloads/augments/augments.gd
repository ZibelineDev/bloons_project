class_name AAugment extends Node


signal augment_purchased(augment : RAugment)


var purchased_augments : Array[RAugment] = []
var augment_pool : Array[RAugment] = []


func initialise() -> void : 
	augment_pool.clear()
	augment_pool.append(load("uid://e27agvnn820r")) #Greed
	augment_pool.append(load("uid://dunsusjdki3yc")) #Minor Range
	augment_pool.append(load("uid://blc8j7ky0ll3h")) #Dart Speed
	augment_pool.append(load("uid://d0uywkfut6rhy")) #Bigger Darts
	augment_pool.append(load("uid://b4ljwy17ufc6m")) #Piercing Darts
	augment_pool.append(load("uid://djni8h5y2kltb")) #Minor Chain
	


func purchase_augment(augment : RAugment) -> void : 
	purchased_augments.append(augment)
	augment_purchased.emit(augment)


func get_augment(augment : RAugment) -> int : 
	return purchased_augments.count(augment)


func pick_random_augment() -> RAugment : 
	var augment : RAugment = augment_pool.pick_random()
	augment_pool.erase(augment)
	return augment
