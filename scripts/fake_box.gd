extends StaticBody2D

@onready var grimjaw = get_tree().get_nodes_in_group("Grimjaw");
@onready var collision_shape_2d = $CollisionShape2D

var is_boss_alive = true

func destroy_colission():
	if !grimjaw:
		is_boss_alive = false
		collision_shape_2d.disabled = true
