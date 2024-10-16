extends Node

var center_divide_scene : PackedScene = preload("res://scenes/set_items/Center_Divide.tscn")
var background_scene: PackedScene = preload("res://scenes/set_items/background.tscn")
var boundary_scene: PackedScene = preload("res://scenes/set_items/Wall_Boundary.tscn")
var out_scene: PackedScene = preload("res://scenes/set_items/Out_Of_Bounds.tscn")
var scores_scene : PackedScene = preload("res://scenes/set_items/Scores.tscn")

static var ai_paddle_scene: PackedScene = preload("res://scenes/game_objects/AIPaddle.tscn")
static var player_paddle_scene: PackedScene = preload("res://scenes/game_objects/Paddle.tscn")
static var ball_scene: PackedScene = preload("res://scenes/game_objects/Ball.tscn")

var mainmenu = load("res://scenes/splash_screens/main_menu.tscn")
var lose_scene = preload("res://scenes/splash_screens/lose_screen.tscn")
var win_scene = preload("res://scenes/splash_screens/win_screen.tscn")

var screen_size: Vector2
var ball
var scores

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	var scalex:float = screen_size.x / 1920
	var scaley:float = screen_size.y / 1080
	var scale = Vector2(scalex, scaley)
	
	#background
	var background = background_scene.instantiate()
	background.size = screen_size
	background.position = -screen_size/2
	add_child(background)
	
	#center divide
	var center = center_divide_scene.instantiate()
	center.scale.y = 25 * scale.y
	add_child(center)
	
	#boundaries
	var boundary1 = boundary_scene.instantiate()
	boundary1.position.y = - screen_size.y / 2 - (screen_size.y * 0.015)
	boundary1.get_node("CollisionShape2D").scale.x = screen_size.x / 16
	boundary1.get_node("Sprite2D").scale.x = screen_size.x / 16
	boundary1.get_node("Sprite2D").scale.y = 1
	add_child(boundary1);
	var boundary2 = boundary_scene.instantiate()
	boundary2.position.y = screen_size.y / 2 + (screen_size.y * 0.015)
	boundary2.get_node("CollisionShape2D").scale.x = screen_size.x / 16
	boundary2.get_node("Sprite2D").scale.x = screen_size.x / 16
	boundary2.get_node("Sprite2D").scale.y = 1
	add_child(boundary2);
	
	#out of bounds
	var left_out = out_scene.instantiate()
	left_out.position.x = - screen_size.x / 2 - 10
	left_out.get_node("CollisionShape2D").scale.y = screen_size.y / 16
	left_out.reset.connect(self.reset_player)
	add_child(left_out)
	var right_out = out_scene.instantiate()
	right_out.position.x = screen_size.x / 2 + 10
	right_out.get_node("CollisionShape2D").scale.y = screen_size.y / 16
	right_out.reset.connect(self.reset_ai)
	add_child(right_out)
	
	#player paddle
	var player = player_paddle_scene.instantiate()
	player.position.x = screen_size.x / 2 - (screen_size.x * 0.025)
	add_child(player)
	
	#ai paddle
	var ai = ai_paddle_scene.instantiate()
	ai.position.x = - screen_size.x / 2 + (screen_size.x * 0.025)
	add_child(ai)
	
	#scores
	scores = scores_scene.instantiate()
	scores.position.y = -screen_size.y / 2
	scores.player_win.connect(self._on_player_win)
	scores.ai_win.connect(self._on_ai_win)
	add_child(scores)
	
	start_game()

func start_game():
	ball = ball_scene.instantiate()
	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $Paddle.position
	ball.position.x = ball.position.x - 50
	self.call_deferred("add_child", ball)

func reset_ai():
	#add point
	scores.on_ai_score()
	
	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $AIPaddle.position
	ball.position.x = ball.position.x + 50
	ball.captured = true
	ball.captured_by_player = false
	self.call_deferred("add_child", ball)
	

func reset_player():	
	#add point
	scores.on_player_score()

	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $Paddle.position
	ball.position.x = ball.position.x - 50
	ball.captured = true
	ball.captured_by_player = true
	self.call_deferred("add_child", ball)
	


func _on_ai_win() -> void:
	#in future, splash screen that says "YOU LOST!"
	get_tree().call_deferred("change_scene_to_packed", lose_scene)


func _on_player_win() -> void:
	#in future, splash screen that says "YOU WIN!"
	get_tree().call_deferred("change_scene_to_packed", win_scene)
