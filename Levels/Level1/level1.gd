extends Node2D

const BOSS_NAME = "CRABINATOR"
const BOSS_HEALTH = 40_000_000
enum FRIEND_TYPES {ADDING, MULTIPLYING, ADDING2, EXPO}
@export var blast_marker: Marker2D
@export var boss: Node2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_ui: CanvasLayer = $MainUI
@onready var lose_secreen_overlay: Lose_Screen = $"Lose Secreen Overlay"
@onready var win_screen: Win_Screen = $WinScreen
var star_particle = preload("res://UI/particles/particle.tscn")


var level1_hand = [
	[
		FRIEND_TYPES.ADDING,
		FRIEND_TYPES.ADDING2,
		FRIEND_TYPES.EXPO,
		FRIEND_TYPES.ADDING,
		FRIEND_TYPES.MULTIPLYING,
		FRIEND_TYPES.ADDING2,
	],
	[
		FRIEND_TYPES.MULTIPLYING,
		FRIEND_TYPES.ADDING,
		FRIEND_TYPES.EXPO,
		FRIEND_TYPES.MULTIPLYING,
	]
]


func _ready() -> void:
	var canvas_position = DisplayServer.screen_get_size()
	prints("canvas1: ", canvas_position)
	GameManager.connect("trigged_pipeline_step", pan_camera)
	GameManager.connect("pipeline_final_step", pan_to_blast_marker)
	var input_hand = level1_hand[randi_range(0,1)]
	main_ui.generate_hand(input_hand)
	main_ui.populate_health_component(BOSS_NAME, BOSS_HEALTH)


func pan_camera(pos: Vector2):
	var particle_instance = star_particle.instantiate()
	particle_instance.position = pos
	add_child(particle_instance)
	particle_instance.emit_particle()
	camera_2d.position = pos


func pan_to_blast_marker():
	animation_player.play("fire_lazur")
	camera_2d.position = blast_marker.position


func check_result():
	main_ui.hide_hand()
	if GameManager.current_damage < BOSS_HEALTH:
		main_ui.free_ui()
		win_screen.free_ui()
		lose_secreen_overlay.play_lose_animation()
	else:
		main_ui.populate_health_component(BOSS_NAME, max(BOSS_HEALTH-GameManager.current_damage,0))
		kill_boss()
		lose_secreen_overlay.free_ui()
		win_screen.play_win_animation()
	GameManager.current_damage = 0

func kill_boss():
	if boss != null:
		boss.die()


func play_sfx_lazer():
	AudioManager.sfx_lazer.play()
