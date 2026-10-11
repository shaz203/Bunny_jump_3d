extends Area3D

var parry_active = false
var isjumping = false
var isgrounded = false

func _on_body_entered(body: Node3D) -> void:
	if body.get_collision_layer_value(2):
		$Parrywindow.start()
		parry_active = true
		isgrounded = true
	

func _process(delta: float) -> void:
	if isjumping==true:
		Jump_time()

func Jump_time():
	if parry_active == true and Input.is_action_just_pressed("jump") and isgrounded==true:
		get_parent().Bunny_jump()
		isjumping=false
		$Parrywindow.is_stopped()
		parry_active=false
		
	elif parry_active == false and isgrounded==true:
		get_parent().failed_bunny()
		isjumping=false
		



func _on_parrywindow_timeout() -> void:
	parry_active = false
	

func _on_body_exited(body: Node3D) -> void:
	if body.get_collision_layer_value(2):
		isjumping = true
		isgrounded=false
		
