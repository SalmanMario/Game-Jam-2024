extends StaticBody2D

var player_in_area = false
var is_chatting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_area and not is_chatting:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("shark")
		is_chatting = false

func run_dialogue(dialogue_string):
	if not is_chatting and Dialogic.current_timeline == null:
		is_chatting = true
		Dialogic.start(dialogue_string)

func _on_chat_zone_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_chat_zone_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
