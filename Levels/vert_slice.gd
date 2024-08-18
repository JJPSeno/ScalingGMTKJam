extends Node2D



@onready var camera_2d: Camera2D = $Camera2D
@onready var pipeline_cutscene_timer: Timer = $PipelineCutsceneTimer
@export var boss: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("trigged_pipeline_step", pan_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func pan_camera(pos: Vector2):
	camera_2d.position = pos
	pipeline_cutscene_timer.start()

func _on_pipeline_cutscene_timer_timeout() -> void:
	if GameManager.pipeline_queue.size() > 0:
		GameManager.run_pipeline_step()
	else:
		pan_camera(boss.position)
