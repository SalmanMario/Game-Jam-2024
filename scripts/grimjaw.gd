extends Node2D

class_name GrimJaw

@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown
var direction = 1
var speed = 250
var bullet_scene = preload("res://scenes/bullet_boss.tscn")
var health = 10
@onready var animation_player = $AnimationPlayer
@onready var shoot_sound_effect = $shoot_sound_effect

func _physics_process(delta):
	if ray_cast_up.is_colliding():
		direction = -1
	if ray_cast_down.is_colliding():
		direction = 1
	position.y += direction * speed * delta
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)
	shoot_sound_effect.play()

func enemy_take_damage():
	health -=1
	animation_player.play("hit_effect")
	
	if health == 0:
		queue_free()
	
func _on_timer_timeout():
	shoot()
