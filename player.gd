extends CharacterBody3D


var speed = 10
var jump_force=8
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_velocity = -100

var isjumping: bool


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta: float) -> void:
	movement()
	jump()
	gravity_on(delta)
	Smash_down()
	move_and_slide()
func _unhandled_input(event):
	player_rotation(event)
func _process(delta: float) -> void:
	Speed_check()

func jump():
	# jump of player
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=jump_force
		isjumping=true
	if !is_on_floor() == true:
		isjumping=false
func movement():
		# Movement for player
	var input_dir_2D=Input.get_vector("move_left","move_right","move_up","move_down")
	var input_direction_3D=Vector3(input_dir_2D.x,0.0,input_dir_2D.y)
	var direction = transform.basis*input_direction_3D
	
	velocity.x = direction.x*speed
	velocity.z=direction.z*speed
func gravity_on(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
func player_rotation(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y-= event.relative.x * 0.5
		$Camera3D.rotation_degrees.x-=event.relative.y*0.5
		$Camera3D.rotation_degrees.x= clamp($Camera3D.rotation_degrees.x,-60,60)
		
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func Smash_down():
	if Input.is_action_just_pressed("smash") and !is_on_floor():
		velocity.y=fall_velocity
		speed=10
func Bunny_jump():
	if speed <50:
		speed+=5
func failed_bunny():
	speed=10
func Speed_check():
	$Label.text = "Speed is: %d" %speed 
