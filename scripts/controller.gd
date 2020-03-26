extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 10
const GRAVITY = 10
const ROTARION = 3
export var mouse_sensitivity = .3
export var camera_x_rotation = 0

onready var controller = get_node("/root/level/controller")
onready var camera = get_node("/root/level/controller/Camera")

export var zoom_step = 0.5
export var zoom_min = 0.5
export var zoom_max = 3.0
export var zoom_speed = 2.0
var zoom_target = 1

var world;

func _ready():
	world = get_parent()
	set_process_input(true)
	set_process(true)
	
# Helper functions
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_foward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _input(event):
	# var zoom = camera
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
	# right left direct movement
	# velocity.y += GRAVITY * delta
	var desired_velocity = get_input() * SPEED

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z

	velocity = move_and_slide(velocity, Vector3.UP, true)
