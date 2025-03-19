class_name AugmentCardChoice extends Control

static var ref : AugmentCardChoice

func _init() -> void : ref = self


@onready var first_card: AugmentCard = %FirstCard
@onready var second_card: AugmentCard = %SecondCard
@onready var third_card: AugmentCard = %ThirdCard


func _ready() -> void :
	visible = false
	first_card.purchased.connect(on_augment_purchased)
	second_card.purchased.connect(on_augment_purchased)
	third_card.purchased.connect(on_augment_purchased)


func initialise_choice() -> void :
	if not SSS.activated : return
	
	(SpeedScale as ASpeedScale).toggle_pause(true)
	visible = true
	first_card.inject_resource(Augments.pick_random_augment())
	second_card.inject_resource(Augments.pick_random_augment())
	third_card.inject_resource(Augments.pick_random_augment())


func on_augment_purchased(augment : RAugment) -> void : 
	visible = false
	(SpeedScale as ASpeedScale).toggle_pause(false)
	Augments.purchase_augment(augment)
