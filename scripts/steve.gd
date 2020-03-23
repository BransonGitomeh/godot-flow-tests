extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 5

func _ready():
	printt("hello ", velocity) 
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$MeshInstance.rotate_z(deg2rad(8))
		# $./floor/MeshInstance.rotate_z(deg2rad(8))
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x,0,.1)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.z = -SPEED
	else:
		velocity.z = lerp(velocity.x,0,.1)
	move_and_slide(velocity)