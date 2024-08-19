extends Node2D

class_name Lose_Screen

@export_group("Internal")
@export var animation_player:AnimationPlayer

func play_lose_animation() -> void:
    animation_player.play("fire_lazur")
