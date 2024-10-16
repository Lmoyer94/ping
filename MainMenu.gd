extends Node

@onready var viewport_size = get_viewport().size
var court = preload("res://scenes/Court.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale: Vector2 = Vector2(0.0, 0.0)
	scale.x = viewport_size.x / 1920
	scale.y = viewport_size.y / 1080
	
	$ColorRect.scale = $ColorRect.scale * scale
	$Label.scale = $Label.scale * scale
	$Buttons.scale = $Buttons.scale * scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(court)


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
