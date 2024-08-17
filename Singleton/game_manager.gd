extends Node

@export var isDebug := true

func _process(_delta)-> void:
	if isDebug:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
		if Input.is_action_just_pressed("reload"):
			get_tree().reload_current_scene()
