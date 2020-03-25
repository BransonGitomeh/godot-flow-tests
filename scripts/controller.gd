extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 10
const ROTARION = 3
export var mouse_sensitivity = .3
export var camera_x_rotation = 0

onready var controller = get_node("/root/level/controller")
onready var camera = get_node("/root/level/controller/Camera")

func _ready():
	pass
	
func _input(event):
	# use the mouse to know direction to move in in our world
	if event is InputEventMouseMotion and Input.is_action_pressed("free_rotate"):
		controller.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		# stop the mouse movement from passing 90 digrees for a more fluid control system
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90 :
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
			# camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))

func _physics_process(delta):
	# movements for the camera, this ist an fps so we dont use mouse movement to tweak the rotation
	# we only pan right, left , foward back. 
	# clicking on an object then hitting ctrl + space should bring the camera xyz units near the selected object to
	# put it in focus
	
	# right left direct movement
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x,0,.1)
		
	# front back movement
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
	else:
		velocity.z = lerp(velocity.x,0,.1)
		
	# higer lower movement
	if Input.is_action_pressed("higher") and Input.is_action_pressed("lower"):
		velocity.y = 0
	elif Input.is_action_pressed("higher"):
		velocity.y = SPEED
	elif Input.is_action_pressed("lower"):
		velocity.y = -SPEED
	else:
		velocity.y = lerp(velocity.x,0,.1)
		
	# camera rotate
	if Input.is_action_pressed("cam_rotate_left") and Input.is_action_pressed("cam_rotate_right"):
		controller.rotate_y(deg2rad(0))
	elif Input.is_action_pressed("cam_rotate_left"):
		controller.rotate_y(deg2rad(ROTARION))
	elif Input.is_action_pressed("cam_rotate_right"):
		controller.rotate_y(deg2rad(-ROTARION))
#	else:
#		camera.rotate_y(deg2rad(lerp(velocity.x,0,.1)))
#		velocity.y = lerp(velocity.x,0,.1)
	move_and_slide(velocity)