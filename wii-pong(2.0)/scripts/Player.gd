extends CharacterBody2D


const SPEED = 10.0
const rotation_speed = 4
const degree_limit = 80
var move_direction = Vector2(0,0)
var degrees = 0
var wiimotes = GDWiimoteServer.finalize_connection()
var connected = false



func _ready():
	pass

func _physics_process(delta: float) -> void:
	Connection()	
	Move()
	spin()
	rotation_degrees = clamp(rotation_degrees, -(degree_limit), degree_limit)
	global_position += move_direction * SPEED
	move_and_slide()

func spin ():
	#var direction := Input.get_axis("Left", "Right")
	if connected == true:
		if wiimotes.size() > 0:
			var wiimote = wiimotes[0]
			var acc = wiimote.get_accel()
			rotation_degrees = ((acc.x) * degree_limit)
	
		if Input.is_action_just_pressed("Hit"):
			if wiimotes.size() > 0:
				var wiimote = wiimotes[0]
				var acc = wiimote.get_accel()
				var raw_acc = wiimote.get_raw_accel()
				var orientation = wiimote.get_raw_orientation()
				var smooth_orientation = wiimote.get_smoothed_orientation()
				print("Acc:", acc)
				print("Raw acc:", raw_acc)
				print("Orientation:", orientation)
				print("Smooth Orientation:", smooth_orientation)
				Vibrate()
			
	#rotation_degrees += rotation_speed * direction

func Move ():
	if Input.is_action_pressed("Left"):
		move_direction = Vector2(-1,0)
		
	if Input.is_action_pressed("Right"):
		move_direction = Vector2(1,0)

	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right"):
		move_direction = Vector2(0,0)
	
	pass

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
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	$"../Ball/StaticBody2D".on_hit = true
	print("Acerto da Bola")
