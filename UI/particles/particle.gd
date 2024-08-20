extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func emit_particle():
	animation_player.play("emit_particle")
