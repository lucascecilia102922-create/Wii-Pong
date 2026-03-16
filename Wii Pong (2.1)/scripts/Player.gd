extends CharacterBody2D

const SPEED = 500.0
const degree_limit = 90
var move_direction = Vector2(0,0)
var degrees = 0
var wiimotes = GDWiimoteServer.finalize_connection()
var connected = false



func _ready():
	pass

func _physics_process(_delta: float) -> void:
	Connection()	
	Move()
	spin()
	rotation_degrees = clamp(rotation_degrees, -(degree_limit), degree_limit)
	move_and_slide()

func spin ():
	if connected == true:
		var wiimote = wiimotes[0]
		var acc = wiimote.get_accel()
		rotation_degrees = ((acc.x) * degree_limit)
	
		#Botão para Desbug:
		if Input.is_action_just_pressed("Hit"):
			if wiimotes.size() > 0:
				var raw_acc = wiimote.get_raw_accel()
				var orientation = wiimote.get_raw_orientation()
				var smooth_orientation = wiimote.get_smoothed_orientation()
				print("Acc:", acc)
				print("Raw acc:", raw_acc)
				print("Orientation:", orientation)
				print("Smooth Orientation:", smooth_orientation)
				Vibrate()
			

func Move ():
	#Alterar este código depois.
	var directionX := Input.get_axis("Left", "Right")
	var directionY := Input.get_axis("Up", "Down")
	
	if directionX or directionY:
		velocity.y = directionY * SPEED
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.x, 0, SPEED)
		
func Vibrate ():
	var wiimote = wiimotes[0]
	wiimote.set_rumble(true)
	await get_tree().create_timer(0.1).timeout
	wiimote.set_rumble(false)
	
func Connection():
	if wiimotes != []:
		if connected == false:
			wiimotes[0].set_motion_sensing(true)
			connected = true
			print("Conexão Realizada")
			
func _on_area_2d_body_entered(_body: Node2D) -> void:
	$"../Ball/StaticBody2D".on_hit = true
	print("Acerto da Bola")
