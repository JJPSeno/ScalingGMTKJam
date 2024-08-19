extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@export var blast_marker: Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("trigged_pipeline_step", pan_camera)
	GameManager.connect("pipeline_final_step", pan_to_blast_marker)


func pan_camera(pos: Vector2):
	camera_2d.position = pos


func pan_to_blast_marker():
	animation_player.play("fire_lazur")
	camera_2d.position = blast_marker.position
