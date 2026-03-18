extends Node2D

func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("enemy").is_empty():
		get_tree().change_scene_to_file("res://scenes/level1.tscn")
