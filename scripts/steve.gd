extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 5
onready var playerMesh = get_node("/root/level/steve/Sphere")
onready var obstacleMesh = get_node("/root/level/obstacle/MeshInstance")
onready var camera = get_node("/root/level/Camera")

func _ready():
	printt("hello ", velocity) 

func _physics_process(delta):
	obstacleMesh.rotate_y(deg2rad(-3))
	playerMesh.rotate_y(deg2rad(3))
	
	
	if Input.is_action_pressed("click"):
		var position2D = get_viewport().get_mouse_position()
		# in this case we get the current y axis because we dont want that to change
		var object_y = playerMesh.transform.origin.y
		
		# if this doesnt work then we will use the keyboard controlls for now
		
		# get current z axis
		var dropPlane  = Plane(Vector3(0, 0, 10), 6)
		var position3D = dropPlane.intersects_ray(
			camera.project_ray_origin(position2D),
			camera.project_ray_normal(position2D)
		)
		
		# then we get the genarated y axis but 
		var generated_y = position3D.y
		
		# set it to the x axis so the user can move the asset using the mouse
		# set the y axis to the older y axis so it doesnt change its up down
		position3D.z = -generated_y
		position3D.y = object_y
		
		printt(position3D,playerMesh.transform.origin)
		# current position
		
		playerMesh.transform.origin = position3D
		
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		playerMesh.rotate_z(deg2rad(-3))
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