extends CharacterBody2D

@export var speed: int = 500
@export var speed_multiplier: float = 1.03
@export var captured: bool = true
@export var captured_by_player: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if captured && not captured_by_player:
		release()

func _physics_process(delta: float) -> void:
	if captured:
		if captured_by_player:
			var player = get_node("../Paddle")
			if player:
				var playerPos = player.position
				var dist = position.y - playerPos.y
	
				if dist > 0:
					position.y = position.y - speed * delta
				elif dist < 0:
					position.y = position.y + speed * delta
		else:
			var ai = get_node("../AIPaddle")
			if ai:
				var aiPos = ai.position
				var dist = position.y - ai.Pos.y
				
				if dist > 0:
					velocity.y = -ai.speed
				elif dist < 0:
					velocity.y = ai.speed
	else:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			velocity = velocity * speed_multiplier
			$AudioStreamPlayer2D.play()
	
	move_and_slide()

func _input(event):
	if velocity == Vector2(0, 0):
		if event.is_action_pressed("release") && captured && captured_by_player:
			release()
	else:
		pass
		
func release():
	captured = false
	captured_by_player = false
	if position.x > 0:
		velocity.x = -speed	
	if position.x < 0:
		velocity.x = speed
		
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	var value = rnd.randi_range(0, 1)
		
	if value == 0:
		velocity.y = -speed / 3
	elif value == 1:
		velocity.y = speed / 3
