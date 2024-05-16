extends Area2D

var traveled_distance = 0

var bullet_position = Global.bullet_direction

func _physics_process(delta):
	const SPEED = 400
	const RANGE = 200
	
	var direction = bullet_position
	position += direction * SPEED * delta
	
	traveled_distance += SPEED * delta
	
	if traveled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("player_take_damage"):
		body.player_take_damage()

