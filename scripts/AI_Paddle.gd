extends CharacterBody2D

@export var ball: CharacterBody2D
@export var speed: int = 415

func get_movement() -> void:
	ball = get_node_or_null("../Ball")
	if ball:
		var ballPos = ball.position
		var dist = position.y - ballPos.y
	
		if dist > 0:
			velocity.y = -speed
		elif dist < 0:
			velocity.y = speed
	
func _physics_process(delta: float) -> void:
	get_movement()
	move_and_slide()
