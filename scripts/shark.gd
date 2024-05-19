extends StaticBody2D

# Export the dialogue name to set it in the editor
@export var dialogue_name: String = "shark"

var player_in_area = false
var is_chatting = false

func _ready():
	# You can initialize any necessary settings here
	pass

func _process(delta):
	if player_in_area and not is_chatting:
		if Input.is_action_just_pressed("interact"):
			run_dialogue(dialogue_name)

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
		is_chatting = false  # Reset chatting flag when player leaves the area
