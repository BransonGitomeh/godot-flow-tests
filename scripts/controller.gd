extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 5

func _ready():
	pass

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
	move_and_slide(velocity)