extends CharacterBody2D
class_name Player

const SPEED = 150
const ACCEL = 1500
const FRICTION = 600
var health = 5

var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var shoot_sound_effect = $ShootSoundEffect

var input = Vector2.ZERO
@onready var anim_player = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	player_movement(delta)
	
func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if Input.is_action_just_pressed("shoot"):
		shoot()
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
			anim_player.play("idle")
	else:
		velocity += (input * ACCEL * delta)
		velocity = velocity.limit_length(SPEED)
		update_animation(input)
		
	move_and_slide()

func update_animation(input):
	if abs(input.x) > abs(input.y):
		if input.x > 0:
			anim_player.flip_h = false
			Global.bullet_direction = Vector2.RIGHT
		else:
			anim_player.flip_h = true
			Global.bullet_direction = Vector2.LEFT
		anim_player.play("moving_animation")
	else:
		if input.y > 0:
			Global.bullet_direction = Vector2.DOWN
		else:
			Global.bullet_direction = Vector2.UP
			
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)
	shoot_sound_effect.play()
	
func player_take_damage():
	health -= 1
	animation_player.play("hit_effect")
	
	if health == 0:
		queue_free()
		respawn()

#func _on_timer_timeout():
	#shoot()
	
func player():
	pass
	
func respawn():
	get_tree().reload_current_scene()

