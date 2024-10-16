extends Node

@onready var ai_score = $AIScore
@onready var player_score = $PlayerScore

signal player_win
signal ai_win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ai_score.text = "0"
	player_score.text = "0"

func on_player_score():
	if player_score.text == "0":
		player_score.text = "15"
	elif player_score.text == "15":
		player_score.text = "30"
	elif player_score.text == "30":
		player_score.text = "40"
	elif player_score.text == "40" && ai_score.text == "40":
		player_score.text = "Deuce"
	elif player_score.text == "40" && ai_score.text == "Deuce":
		player_score.text = "Deuce"
		ai_score.text = "40"
	elif player_score.text == "40" && (ai_score.text != "40" || ai_score.text != "Deuce"):
		player_score.text = "WIN"
		player_win.emit()
	elif player_score.text == "Deuce":
		player_score.text = "WIN"
		player_win.emit()
	
func on_ai_score():
	if ai_score.text == "0":
		ai_score.text = "15"
	elif ai_score.text == "15":
		ai_score.text = "30"
	elif ai_score.text == "30":
		ai_score.text = "40"
	elif ai_score.text == "40" && player_score.text == "40":
		ai_score.text = "Deuce"
	elif ai_score.text == "40" && player_score.text == "Deuce":
		ai_score.text = "Deuce"
		player_score.text = "40"
	elif ai_score.text == "40" && (player_score.text != "40" || player_score.text != "Deuce"):
		ai_score.text = "WIN"
		ai_win.emit()
	elif ai_score.text == "Deuce":
		ai_score.text = "WIN"
		ai_win.emit()
