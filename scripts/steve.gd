extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 10

onready var playerMesh = get_node("/root/level/steve/Sphere")
onready var obstacleMesh = get_node("/root/level/obstacle/MeshInstance")
onready var camera = get_node("/root/level/controller/Camera")

const is_moving = true
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

func x_physics_process(delta):
	obstacleMesh.rotate_y(deg2rad(-3))
	playerMesh.rotate_y(deg2rad(3))
	
func _physics_process(delta):
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
		
		if position3D: 
		# then we get the genarated y axis but 
			var generated_y = position3D.y
			
			# set it to the x axis so the user can move the asset using the mouse
			# set the y axis to the older y axis so it doesnt change its up down
			position3D.z = -generated_y
			position3D.y = object_y
			
			# printt(position3D,playerMesh.transform.origin)
			# current position
			
			#playerMesh.transform.origin = position3D
			
			var scene = load("res://assets/steve.tscn")
			var player = scene.instance()
			add_child(player)
			
			player.transform.origin = position3D
			player.rotate_y(deg2rad(3))
			
	