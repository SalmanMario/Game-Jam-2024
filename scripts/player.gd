extends CharacterBody2D

const SPEED = 150
const ACCEL = 1500
const FRICTION = 600

var input = Vector2.ZERO
@onready var anim_player = $AnimatedSprite2D

func _physics_process(delta):
	player_movement(delta)
	
func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
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
		else:
			anim_player.flip_h = true
		anim_player.play("moving_animation")
	#else:
		#if input.y > 0:
			#anim_player.play("moving_down_animation")
		#else:
			#anim_player.play("moving_up_animation")

func player():
	pass
