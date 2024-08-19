extends Node2D

class_name Win_Screen

@export_group("Internal")
@export var next_scene: PackedScene
@export var animation_player:AnimationPlayer


func play_win_animation() -> void:
	animation_player.play("show_win_overlay")


func free_ui():
	queue_free()


func _on_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_full
	get_tree().change_scene_to_packed(next_scene)
