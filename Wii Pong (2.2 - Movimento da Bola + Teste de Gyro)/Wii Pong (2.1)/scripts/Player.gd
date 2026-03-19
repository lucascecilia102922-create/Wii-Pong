extends CharacterBody2D

const SPEED = 500.0
const degree_limit = 90
@onready var area_direita = $Direita
var move_direction = Vector2(0,0)
var degrees = 0
var wiimotes = GDWiimoteServer.finalize_connection()
var connected = false  
var _is_calibrated := false

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
		#var acc_close = snapped(acc.x, 0.0001)
		rotation_degrees = ((acc.x) * degree_limit)
		
		#Botão para Desbug:
		if Input.is_action_just_pressed("Hit"):
			if wiimotes.size() > 0:
				var raw_acc = wiimote.get_raw_accel()
				var orientation = wiimote.get_raw_orientation()
				var smooth_orientation = wiimote.get_smoothed_orientation()
				var gyro = wiimote.get_player_space_gyro(0.1)
				var gyroRaw = wiimote.get_raw_gyro()
				#print("Acc_close: ", acc_close)
				print("Raw acc:", raw_acc)
				print("Orientation:", orientation)
				print("Smooth Orientation:", smooth_orientation)
				print("Gyro:",gyro)
				print("GyroRaw:",gyroRaw)
				if _is_calibrated == false:
					calibrate_gyro()
				#Vibrate()
			

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
			wiimotes[0].set_motion_plus(true)
			wiimotes[0].set_motion_processing(true)

			connected = true
			print("Conexão Realizada")

func calibrate_gyro(dt: float = 5.) -> void:
	if connected == true:
		var wiimote = wiimotes[0]
		_is_calibrated = false
		wiimote.reset_gyro_calibration()
		wiimote.start_gyro_calibration()
		print("Calibrating...")
		get_tree().create_timer(dt).timeout.connect(
			func(): print("Calibration complete."); wiimote.stop_gyro_calibration(); _is_calibrated = true;
			)
		_is_calibrated = true


func _on_direita_area_entered(area: Area2D) -> void:
	$"../Ball/StaticBody2D".on_hit = true
	$"../Ball/StaticBody2D".Lado = "Direita"
	print("Acerto da Bola para a Direita")
	pass # Replace with function body.


func _on_meio_area_entered(area: Area2D) -> void:
	$"../Ball/StaticBody2D".on_hit = true
	$"../Ball/StaticBody2D".Lado = "Meio"
	print("Acerto da Bola para o Meio")
	pass # Replace with function body.


func _on_esquerda_area_entered(area: Area2D) -> void:
	$"../Ball/StaticBody2D".on_hit = true
	$"../Ball/StaticBody2D".Lado = "Esquerda"
	print("Acerto da Bola para a Esquerda")
	pass # Replace with function body.
