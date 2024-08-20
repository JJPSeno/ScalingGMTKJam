extends Node2D

class_name Lose_Screen

@export_group("Internal")
@export var animation_player:AnimationPlayer

func play_lose_animation() -> void:
	animation_player.play("fire_lazur")


func free_ui():
	queue_free()

func play_sfx_lazer():
	AudioManager.sfx_lazer.play()

func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()
