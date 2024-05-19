extends CharacterBody2D

var health = 3

var speed = 75
var player_chase = false
var player = null
var bullet_scene = preload("res://scenes/bullet_enemy.tscn")
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer

func shoot():
	audio_stream_player.play()
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)

func _physics_process(delta):
	if player_chase and player:
		var direction = (player.position - position).normalized()
		position += direction * speed * delta 

func _on_detection_player_body_entered(body):
	if body.name == "Player":
		player = body
		player_chase = true
	
func _on_detection_player_body_exited(body):
	if body == player:
		player_chase = false

func enemy_take_damage():
	health -=1
	animation_player.play("hit_effect")
	
	if health == 0:
		queue_free()

func _on_timer_timeout():
	if player_chase == true:
		shoot()
