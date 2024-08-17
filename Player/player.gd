extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DRAG = .4

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity * DRAG

	move_and_slide()
