extends Control

@export var local_debug := false
var damage : int:
	set = set_damage

var label_settings: LabelSettings = preload("res://UI/damage_label_settings.tres")

#region testing variables
var cooldown := 0.1
var TEST_mutable_damage := 9223372036854775807
#endregion

@onready var label: Label = $Label

func _ready() -> void:
	if !local_debug:
		set_damage(2322313123123121100)
		label.text = format(damage)


func _physics_process(delta):
	if local_debug:
		run_test(delta)


func format(int_damage: int) -> String:
	var str_damage := String.num_int64(int_damage)
	var str_len := str_damage.length()
	var buffer : Array[String]
	var ret_string : String
	set_juice_level(str_len)
	
	while str_len > 0:
		buffer.push_front(str_damage.right(3))
		str_damage = str_damage.left(max(str_len-3,0))
		str_len = str_damage.length()
	
	ret_string = ",".join(buffer)
	
	return ret_string

func set_juice_level(length: int) -> void:
	label_settings.font_size = 16
	label_settings.font_color = Color.WHITE_SMOKE
	if length < 3:
		return
	elif length < 6:
		label_settings.font_size = 24
		label_settings.font_color = Color.LIGHT_SALMON
	elif length < 9:
		label_settings.font_size = 32
		label_settings.font_color = Color.LIGHT_SALMON
	elif length < 12:
		label_settings.font_size = 32
		label_settings.font_color = Color.ORANGE
	elif length < 15:
		label_settings.font_size = 40
		label_settings.font_color = Color.ORANGE_RED
	elif length < 19:
		label_settings.font_size = 48
		label_settings.font_color = Color.ORANGE_RED
	else:
		label_settings.font_size = 64
		label_settings.font_color = Color.RED


func set_damage(input_damage: int = 0) -> void:
	damage = input_damage

func run_test(delta):
	cooldown -= delta
	if cooldown <= 0 and TEST_mutable_damage>=0:
		label.text = format(TEST_mutable_damage)
		TEST_mutable_damage = max(TEST_mutable_damage / 10, 0)
		cooldown = 2.0