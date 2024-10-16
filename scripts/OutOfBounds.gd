extends Node

signal reset

func _on_body_entered(body: Node2D) -> void:
	if body == get_node("../Ball"):
		reset.emit()
