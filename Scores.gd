extends Node

@onready var AIScore = $AIScore
@onready var PlayerScore = $PlayerScore

signal PlayerWin
signal AIWin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AIScore.text = "0"
	PlayerScore.text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func OnPlayerScore():
	if PlayerScore.text == "0":
		PlayerScore.text = "15"
	elif PlayerScore.text == "15":
		PlayerScore.text = "30"
	elif PlayerScore.text == "30":
		PlayerScore.text = "40"
	elif PlayerScore.text == "40" && AIScore.text != "40":
		PlayerScore.text = "WIN"
		PlayerWin.emit()
	elif PlayerScore.text == "40" && AIScore.text == "40":
		PlayerScore.text == "Deuce"
	elif PlayerScore.text == "40" && AIScore.text == "Deuce":
		PlayerScore.text = "Deuce"
		AIScore.text = "40"
	elif PlayerScore.text == "Deuce":
		PlayerScore.text = "WIN"
		PlayerWin.emit()
	
func OnAIScore():
	if AIScore.text == "0":
		AIScore.text = "15"
	elif AIScore.text == "15":
		AIScore.text = "30"
	elif AIScore.text == "30":
		AIScore.text = "40"
	elif AIScore.text == "40" && PlayerScore.text != "40":
		AIScore.text = "WIN"
		AIWin.emit()
	elif AIScore.text == "40" && PlayerScore.text == "40":
		AIScore.text = "Deuce"
	elif AIScore.text == "40" && PlayerScore.text == "Deuce":
		AIScore.text = "Deuce"
		PlayerScore.text = "40"
	elif AIScore.text == "Deuce":
		AIScore.text = "WIN"
		AIWin.emit()
