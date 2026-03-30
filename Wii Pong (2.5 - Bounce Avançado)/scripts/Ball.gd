extends StaticBody2D
const scale_ball = Vector2(0.010,0.010)
const scale_speed = 200.0
@onready var max_scale = scale
#Vector2(1.5,1.5)
const min_scale = Vector2(0.2,0.2)
@onready var Ball = $Area2D
var Speed = 400
var on_hit = false
var child_exists: bool = false
var Lado = "meio"
var timer = 0.3
@onready var initial_pos = global_position
#var going_in = false
#var going_back : bool =  false
#var counter = 0
var time := 0.0


func _ready() -> void:
	remove_child(Ball)
	child_exists = false
	#await get_tree().create_timer(1).timeout
	#add_child(Ball)

func _process(delta: float) -> void:
	Move(delta)
	Grow(delta)
	

func Grow(delta):
	#Quando a bola é acertada:
	if on_hit == true:
		if child_exists == true:
			remove_child(Ball)
			#going_in = true
			child_exists = false
			#counter = 0
			time = 0
		scale -= scale_ball * scale_speed * delta
		Bounce(delta)
		
		if scale <= min_scale:
			Lado = "Meio"
			on_hit = false		
			
			
	elif on_hit == false and scale <= max_scale:
		scale += scale_ball * scale_speed * delta
		Bounce(delta)
		
	#if scale >= max_scale
	else:
		if child_exists == false:
			add_child(Ball)
			child_exists = true
		

#func Direction():
	#match Lado:
		#"Direita":
			#global_position.x += Speed
			#print("direita")
		#"Esquerda":
			#print("Esquerda")
		#"Meio":
			#print("Meio")

func Move(delta):
	#var depth = inverse_lerp(min_scale.x, max_scale.x, scale.x)
	var dir = 0
	
	
	match Lado:
		"Direita":
			dir = 1
		"Esquerda":
			dir = -1
	
	global_position.x += dir * Speed * delta

func Bounce(delta):
	time += delta
	var depth = inverse_lerp(min_scale.x, max_scale.x, scale.x)
	
	# 0 Menos 120 (primeiro valor) define a distância que ele poderá percorrer verticalmente:
	var base_y = lerp(initial_pos.y - 120, initial_pos.y, depth)
	
	# O valor multiplicado pelo time seria a frequência do bounce.
	# Já o valor do meio seria a amplitude, ou o tamanho do pulo:
	
	var bounce = sin(time * 10) * 70 * (1.0 - depth)
	
	# Para o Bounce começar indo para baixo, inverter o sinal acima.
	
	global_position.y = base_y + bounce
	
	#// Segundo Teste do Bounce:
	# Primeiro Movimento, ao acertar a bola (Muito pra cima, e bounce no outro lado)
	#if on_hit:
		#if going_in:
			#global_position.y -= bounce_speed
			#counter += 1
			#
			#if counter >= 50:
				#going_in = false
				#counter = 0
	#
		#else:
			#global_position.y += bounce_speed
			#counter += 1
			#if counter >= 30:
				#going_in = true
				#counter = 0
	#
	## Devolução, ao oponente acertar a bola (Muito pra cima, e bounce na frente do player) 
	#else:
		#if going_back:
			#global_position.y -= bounce_speed
			#counter += 1
			#if counter >= 30:
				#going_back = false
				#counter = 0
	#
		#else:
			#global_position.y += bounce_speed
			#counter += 1
			#if counter >= 50:
				#going_back = true
				#counter = 0
	#
	
	
	#// Primeiro Teste do Bounce:
	#timer -= delta
	#
	#if going_in:
		#global_position.y += bounce_speed
	#
	#else:
		#global_position.y -= bounce_speed
	#
	#if timer <= 0:
		#going_in = !going_in
		#timer = 0.3
	#
	pass
