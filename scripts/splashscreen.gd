extends Node

var mainmenu = load("res://scenes/splash_screens/main_menu.tscn")
var court = load("res://scenes/set_items/Court.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_yes_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", court)


func _on_no_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", mainmenu)
