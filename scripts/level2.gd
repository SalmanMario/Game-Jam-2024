extends Node2D
@onready var load_next_level = $load_next_level


func _on_load_next_level_body_entered(body):
	if body is Player:
		call_deferred("change_scene")
		
func change_scene():
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
