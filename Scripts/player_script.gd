extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var camera = $Camera3D
@onready var interaction_raycast : RayCast3D = $Camera3D/RayCast3D #Make sure the node reference is set correctly
@onready var interaction_label : Label = $Label
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var interaction_is_reset : bool = true

# Checks if Raycast3D hits something to interact with:
func _process(_delta):
	if interaction_raycast.is_colliding():
		var interactable = interaction_raycast.get_collider()
		interaction_is_reset = false
		if interactable != null and interactable.has_method("interact"):
			interaction_label.text = "Press E to interact"
		else:
			interaction_label.text = ""
	else:
		if !interaction_is_reset:
			interaction_label.text = ""
			interaction_is_reset = true

# Calls the interact function on what the Raycast is colliding with, passing self.

func _input(event: InputEvent):
	if event.is_action_pressed("interact"): #Adjust to match your InputMap
		if interaction_raycast.is_colliding():
			var interactable = interaction_raycast.get_collider()
			if interactable.has_method("interact"):
				interactable.interact()
				
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.006)
			camera.rotate_x(-event.relative.y * 0.006)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(60)) #camera rotation limits


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
