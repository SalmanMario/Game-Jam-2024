extends Area2D

var bullet = preload("res://scenes/bullet_boss.tscn")
var traveled_distance = 0

func _physics_process(delta):
	const SPEED = 400
	const RANGE = 300
	
	var direction = Vector2.LEFT
	position += direction * SPEED * delta
	
	traveled_distance += SPEED * delta
	
	if traveled_distance > RANGE:
		queue_free()
		
func _on_body_entered(body):
	if body.has_method("player_take_damage"):
		body.player_take_damage()
	
	
