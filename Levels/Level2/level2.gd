extends Node2D

const BOSS_NAME = "DRAGOGONATRARA"
const BOSS_HEALTH = 20_000_000_000_000
enum FRIEND_TYPES {ADDING, MULTIPLYING, ADDING2, EXPO}
@export var blast_marker: Marker2D
@export var boss: Node2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_ui: CanvasLayer = $MainUI
@onready var lose_secreen_overlay: Lose_Screen = $"Lose Secreen Overlay"
var level2_hand = [
	FRIEND_TYPES.ADDING,
	FRIEND_TYPES.ADDING,
	FRIEND_TYPES.MULTIPLYING,
	FRIEND_TYPES.ADDING2,
	FRIEND_TYPES.ADDING2,
	FRIEND_TYPES.EXPO
]

func _ready() -> void:
	GameManager.connect("trigged_pipeline_step", pan_camera)
	GameManager.connect("pipeline_final_step", pan_to_blast_marker)
	var input_hand = level2_hand
	main_ui.generate_hand(input_hand)
	main_ui.populate_health_component(BOSS_NAME, BOSS_HEALTH)


func pan_camera(pos: Vector2):
	camera_2d.position = pos


func pan_to_blast_marker():
	animation_player.play("fire_lazur")
	camera_2d.position = blast_marker.position

func check_result():
	main_ui.hide_hand()
	if GameManager.current_damage < BOSS_HEALTH:
		main_ui.free_ui()
		lose_secreen_overlay.play_lose_animation()
	else:
		main_ui.populate_health_component(BOSS_NAME, max(BOSS_HEALTH-GameManager.current_damage,0))
		kill_boss()
	GameManager.current_damage = 0

func kill_boss():
	if boss != null:
		boss.die()
