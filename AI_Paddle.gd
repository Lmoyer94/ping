extends CharacterBody2D

@export var ball: CharacterBody2D
@export var speed: int = 425

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass


func get_movement() -> void:
	ball = get_node("../Ball")
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
