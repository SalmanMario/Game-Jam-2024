extends CharacterBody2D

var health = 3

var speed = 25
var player_chase = false
var player = null
var bullet_scene = preload("res://scenes/bullet_enemy.tscn")

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)

func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / speed 

func _on_detection_player_body_entered(body):
	player = body
	player_chase = true
	
func _on_detection_player_body_exited(body):
	player = body
	player_chase = false

func enemy_take_damage():
	health -=1
	
	if health == 0:
		queue_free()


func _on_timer_timeout():
	if player_chase == true:
		shoot()
