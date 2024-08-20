extends Node2D

class_name Win_Screen

@export_group("Internal")
@export var next_scene: PackedScene
@export var animation_player:AnimationPlayer
@onready var next_scene_button: Button = $CanvasLayer/Control/NextSceneButton
@onready var thanks_label: Label = $CanvasLayer/Control/ThanksLabel


func _ready() -> void:
	thanks_label.visible = false
	next_scene_button.visible = false


func play_win_animation() -> void:
	animation_player.play("show_win_overlay")


func free_ui():
	queue_free()


func show_label():
	if next_scene != null:
		next_scene_button.visible = true
	else:
		thanks_label.visible = true


func _on_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_full
	get_tree().change_scene_to_packed(next_scene)
