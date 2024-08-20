extends Node

const MAX_HAND_SIZE = 1
const MAX_INT = 9223372036854775807

signal set_up_card(type: int)
signal trigged_pipeline_step(pos: Vector2)
signal damage_changed(current_damage: int)
signal pipeline_final_step

signal level1_cleared
signal level1_failed

signal level2_cleared
signal level2_failed

@export var isDebug := false
enum FRIEND_TYPES {ADDING, MULTIPLYING, ADDING2, EXPO}

var base_card = preload("res://Cards/base_card.tscn")
var base_friend = preload("res://Friends/base_friend.tscn")

var baseballer_sprite = preload("res://Assets/baseballer.png")
var witch_sprite = preload("res://Assets/witch.png")
var bazookaneer_sprite = preload("res://Assets/bazookaneer.png")
var buddhist_sprite = preload("res://Assets/buddhist.png")

var friends_dictionary = {
	FRIEND_TYPES.ADDING: {
		"friend_name": "Batter",
		"sprite": baseballer_sprite,
		"description": "Reliable Damage",
		"cost": "2",
		"type": FRIEND_TYPES.ADDING
	},
	FRIEND_TYPES.MULTIPLYING: {
		"friend_name": "Witch",
		"sprite": witch_sprite,
		"description": "Force multiplier",
		"cost": "3",
		"type": FRIEND_TYPES.MULTIPLYING
	},
	FRIEND_TYPES.ADDING2: {
		"friend_name": "Bazookaneer",
		"sprite": bazookaneer_sprite,
		"description": "BEEG DEEPS",
		"cost": "3",
		"type": FRIEND_TYPES.ADDING2
	},
	FRIEND_TYPES.EXPO: {
		"friend_name": "Buddhist",
		"sprite": buddhist_sprite,
		"description": "For those who believe",
		"cost": "3",
		"type": FRIEND_TYPES.EXPO
	},
}

enum BOSSES {CRAB, DRAGON}
# element interface is { "type": FRIEND_TYPES, "position": Vector2 }
var pipeline_queue = []
var running_pipeline = []
var is_pipeline_locked = false
var current_damage := 0
var timer: Timer
var can_run_step = true
var rng

func _ready() -> void:
	rng = RandomNumberGenerator.new()

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


func run_pipeline_step(step):
	match step.type:
		FRIEND_TYPES.ADDING:
			current_damage += rng.randi_range(1130, 2222)
		FRIEND_TYPES.MULTIPLYING:
			current_damage *= rng.randi_range(200, 300)
		FRIEND_TYPES.ADDING2:
			current_damage += rng.randi_range(111111, 222222)
		FRIEND_TYPES.EXPO:
			current_damage *= rng.randi_range(2000, 3000)
	if signi(current_damage)<0:
		current_damage = max(current_damage, MAX_INT)
	emit_signal("damage_changed", current_damage)
	emit_signal("trigged_pipeline_step", step.position)


func start_full_pipeline():
	is_pipeline_locked = true
	running_pipeline = pipeline_queue
	generate_queue_timer()
	if running_pipeline.size() > 0:
		run_pipeline_step(running_pipeline.pop_front())
	else:
		end_full_pipeline()

func end_full_pipeline():
	emit_signal("damage_changed", current_damage)
	timer.queue_free()
	is_pipeline_locked = false
	pipeline_queue = []
	emit_signal("pipeline_final_step")

func generate_queue_timer():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.start()
	timer.connect("timeout", _on_queue_timer_timeout)

func _on_queue_timer_timeout() -> void:
	if running_pipeline.size() > 0:
		run_pipeline_step(running_pipeline.pop_front())
	else:
		end_full_pipeline()
