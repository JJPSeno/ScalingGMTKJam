extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var q = pow((200000+200000)*100*100, 17.0)
	prints(q)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
