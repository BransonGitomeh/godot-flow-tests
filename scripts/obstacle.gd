extends RigidBody

func _ready():
	pass

func _input_event(camera, event, click_position, click_normal, shape_idx):
	# Change material to show highlight
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
        print("Obstacle click at: ", event.position, " shape:", shape_idx)
	# Change Material to show its no longer selected
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
        print("Obstacle unclick at: ", event.position, " shape:", shape_idx)