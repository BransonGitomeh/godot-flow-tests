extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 5
onready var playerMesh = get_node("/root/level/steve/Sphere")
onready var obstacleMesh = get_node("/root/level/obstacle/MeshInstance")
onready var camera = get_node("/root/level/Camera")

const is_moving = false
const is_selecting = true

func _ready():
	printt("hello ", velocity) 

func _input_event(camera, event, click_position, click_normal, shape_idx):
	# Change material to show highlight
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
        print("Steve click at: ", event.position, " shape:", shape_idx)
	# Change Material to show its no longer selected
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
        print("Steve unclick at: ", event.position, " shape:", shape_idx)

func x2_physics_process(delta):
	obstacleMesh.rotate_y(deg2rad(-3))
	playerMesh.rotate_y(deg2rad(3))
	
func x_physics_process(delta):
	obstacleMesh.rotate_y(deg2rad(-3))
	playerMesh.rotate_y(deg2rad(3))
	
	# move the selected object
	if Input.is_action_pressed("click") and is_moving == true:
		var position2D = get_viewport().get_mouse_position()
		# in this case we get the current y axis because we dont want that to change
		var object_y = playerMesh.transform.origin.y
		
		# if this doesnt work then we will use the keyboard controlls for now - nvm, it worked
		
		# get position of the mouse 
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
		
		# printt(position3D,playerMesh.transform.origin)
		# current position
		
		playerMesh.transform.origin = position3D
		
		
	# movements for the camera, this ist an fps so we dont use mouse movement to tweak the rotation
	# we only pan right, left , foward back. 
	# clicking on an object then hitting ctrl + space should bring the camera xyz units near the selected object to
	# put it in focus
	
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