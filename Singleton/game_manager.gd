extends Node

const MAX_HAND_SIZE = 1

signal set_up_card(type: int)
signal trigged_pipeline_step(pos: Vector2)

@export var isDebug := true
enum FRIEND_TYPES {ADDING, MULTIPLYING}

var base_card = preload("res://Cards/base_card.tscn")
var base_friend = preload("res://Friends/base_friend.tscn")

var baseballer_sprite = preload("res://Assets/baseballer.png")
var witch_sprite = preload("res://Assets/witch.png")

var friends_dictionary = {
	FRIEND_TYPES.ADDING: {
		"friend_name": "Adding Friend",
		"sprite": baseballer_sprite,
		"description": "Add 10 damage",
		"cost": "2",
		"type": FRIEND_TYPES.ADDING
	},
	FRIEND_TYPES.MULTIPLYING: {
		"friend_name": "Multiplying Friend",
		"sprite": witch_sprite,
		"description": "Multiply damage by 2",
		"cost": "3",
		"type": FRIEND_TYPES.MULTIPLYING
	},
}

enum BOSSES {CRAB, DRAGON}

# element interface is { "type": FRIEND_TYPES, "position": Vector2 }
var pipeline_queue = []

var current_damage := 0

func _process(_delta)-> void:
	if isDebug:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
		if Input.is_action_just_pressed("reload"):
			get_tree().reload_current_scene()


func generate_card(type: int) -> Card:
	var return_card = base_card.instantiate()
	return_card.card_name = friends_dictionary[type].friend_name
	return_card.sprite = friends_dictionary[type].sprite
	return_card.description = friends_dictionary[type].description
	return_card.cost = friends_dictionary[type].cost
	return_card.card_type = friends_dictionary[type].type
	return return_card


func generate_friend(type: int) -> Friend:
	var return_friend = base_friend.instantiate()
	return_friend.friend_type = type
	return_friend.sprite = friends_dictionary[type].sprite
	return return_friend


func run_pipeline_step():
	if pipeline_queue.is_empty():
		return
	var step = pipeline_queue.pop_front()
	match step.type:
		FRIEND_TYPES.ADDING:
			current_damage += 10
		FRIEND_TYPES.MULTIPLYING:
			current_damage *= 2
	emit_signal("trigged_pipeline_step", step.position)
