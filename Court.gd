extends Node

var CenterDivide : PackedScene = preload("res://scenes/Center_Divide.tscn")
var Background: PackedScene = preload("res://scenes/background.tscn")
var Boundary: PackedScene = preload("res://scenes/Wall_Boundary.tscn")
var OutOfBounds: PackedScene = preload("res://scenes/Out_Of_Bounds.tscn")
var Scores : PackedScene = preload("res://scenes/Scores.tscn")

static var AIPaddle: PackedScene = preload("res://scenes/AIPaddle.tscn")
static var PlayerPaddle: PackedScene = preload("res://scenes/Paddle.tscn")
static var Ball: PackedScene = preload("res://scenes/Ball.tscn")

var MainMenu : PackedScene = preload("res://scenes/main_menu.tscn")

var screen_size: Vector2
var scores

signal AIScore
signal PlayerScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	var scalex:float = screen_size.x / 1920
	var scaley:float = screen_size.y / 1080
	var scale = Vector2(scalex, scaley)
	
	#background
	var background = Background.instantiate()
	background.size = screen_size
	background.position = -screen_size/2
	add_child(background)
	
	#center divide
	var center = CenterDivide.instantiate()
	center.scale.y = screen_size.y * scale.y
	add_child(center)
	
	#boundaries
	var boundary1 = Boundary.instantiate()
	boundary1.position.y = - screen_size.y / 2 - (screen_size.y * 0.015)
	boundary1.get_node("CollisionShape2D").scale.x = screen_size.x / 16
	boundary1.get_node("Sprite2D").scale.x = screen_size.x / 16
	boundary1.get_node("Sprite2D").scale.y = 1
	add_child(boundary1);
	var boundary2 = Boundary.instantiate()
	boundary2.position.y = screen_size.y / 2 + (screen_size.y * 0.015)
	boundary2.get_node("CollisionShape2D").scale.x = screen_size.x / 16
	boundary2.get_node("Sprite2D").scale.x = screen_size.x / 16
	boundary2.get_node("Sprite2D").scale.y = 1
	add_child(boundary2);
	
	#out of bounds
	var left_out = OutOfBounds.instantiate()
	left_out.position.x = - screen_size.x / 2 - 10
	left_out.get_node("CollisionShape2D").scale.y = screen_size.y / 16
	left_out.Reset.connect(self.ResetPlayer)
	add_child(left_out)
	var right_out = OutOfBounds.instantiate()
	right_out.position.x = screen_size.x / 2 + 10
	right_out.get_node("CollisionShape2D").scale.y = screen_size.y / 16
	right_out.Reset.connect(self.ResetAI)
	add_child(right_out)
	
	#ball
	var ball = Ball.instantiate()
	add_child(ball)
	
	#player paddle
	var player = PlayerPaddle.instantiate()
	player.position.x = screen_size.x / 2 - (screen_size.x * 0.025)
	add_child(player)
	
	#ai paddle
	var ai = AIPaddle.instantiate()
	ai.position.x = - screen_size.x / 2 + (screen_size.x * 0.025)
	add_child(ai)
	
	#scores
	scores = Scores.instantiate()
	scores.position.x = -screen_size.x / 2
	scores.position.y = -screen_size.y / 2
	scores.PlayerWin.connect(self._on_player_win)
	scores.AIWin.connect(self._on_ai_win)
	add_child(scores)
	
	StartGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func StartGame():
	RemoveBall()
	var ball = Ball.instantiate()
	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $Paddle.position
	ball.position.x = ball.position.x - 100
	self.call_deferred("add_child", ball)

func RemoveBall():
	$Ball.free()

func ResetAI():
	RemoveBall()
	
	#add point
	scores.OnAIScore()
	
	var ball = Ball.instantiate()
	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $AIPaddle.position
	ball.position.x = ball.position.x + 100
	ball.captured = true
	ball.captured_by_player = false
	self.call_deferred("add_child", ball)
	

func ResetPlayer():
	RemoveBall()
	
	#add point
	scores.OnPlayerScore()
	
	var ball = Ball.instantiate()
	ball.speed = 500
	ball.velocity = Vector2(0, 0)
	ball.position = $Paddle.position
	ball.position.x = ball.position.x - 100
	self.call_deferred("add_child", ball)
	


func _on_ai_win() -> void:
	#in future, splash screen that says "YOU LOST!"
	get_tree().change_scene_to_packed(MainMenu)


func _on_player_win() -> void:
	#in future, splash screen that says "YOU WIN!"
	get_tree().change_scene_to_packed(MainMenu)
