extends CanvasLayer

signal transition_full
signal transition_finished
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass # Replace with function body.


func transition():
	color_rect.visible = true
	animation_player.play("sweep_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "sweep_in"):
		transition_full.emit()
		animation_player.play("sweep_out")
	elif (anim_name == "sweep_out"):
		color_rect.visible = false
		transition_finished.emit()
