extends StaticBody2D
const scale_ball = Vector2(0.008,0.008)  #Menor valor possível: 0.008,  Atual: 0.0010
const scale_speed = 200.0
const bounce_speed = 1
const min_scale = Vector2(0.2,0.2)

@onready var max_scale = scale
@onready var Ball1 = $"Colisão Player 1"
@onready var Ball2 = $"Colisão Player 2"
@onready var initial_pos = global_position
@onready var tree = get_tree()
@onready var parent_node = get_parent()
#Vector2(1.5,1.5)

var Lado = "Meio"
var Speed = 175
var on_hit = false
var back_hit = false
var child_exists: bool = false
var time := 0.0
var timer = 0
var serve = true

#var going_in = false
#var going_back : bool =  false
#var counter = 0



func _ready() -> void:
	remove_child(Ball1)
	remove_child(Ball2)
	child_exists = false

func _process(delta: float) -> void:
	Move(delta)
	Grow(delta)
	

func Grow(delta):
	#Quando a bola é acertada:
	if on_hit == true and back_hit == false:
		if child_exists == true:
			remove_child(Ball1)
			child_exists = false
			time = 0
		scale -= scale_ball * scale_speed * delta
		Bounce(delta)
		
		if scale <= min_scale:
			Lado = "Meio"
			if child_exists == false:
				add_child(Ball2)
				child_exists = true	
				on_hit = false	
				
	elif on_hit == false and back_hit == false and scale <= min_scale:
		hit_delay(delta)		
			
	elif on_hit == false and scale <= max_scale and back_hit == true:
		if child_exists == true:
			remove_child(Ball2)
			child_exists = false
		scale += scale_ball * scale_speed * delta
		Bounce(delta)
		
	if scale >= max_scale:
		if child_exists == false:
			add_child(Ball1)
			child_exists = true
			back_hit = false
			Lado = "Meio"
			timer = 0
		hit_delay(delta)

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
	var dir = 0
	
	match Lado:
		"Direita":
			dir = 1
		"Esquerda":
			dir = -1
		"Meio":
			dir = 0
	
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

func Point():
	if scale >= max_scale:
		print("Ponto pro jogador 2")
		GlobalLabel.score2 += 1
	
	else:
		print("Ponto pro jogador 1")
		GlobalLabel.score1 += 1
		
	#self.visible = false
	Respawn()
	
	#scale = max_scale
	#global_position = initial_pos
	#
	#if on_hit == false:
		#freeze = true
		#pass

func Respawn():
	timer = 0
	parent_node.remove_child(self)
	await tree.create_timer(2).timeout
	scale = max_scale
	parent_node.add_child(self)
	
	if has_node("./Colisão Player 2"):
		remove_child(Ball2)
		add_child(Ball1)
	global_position = initial_pos
	serve = true
	on_hit = false
	
func hit_delay(delta):
		if serve == false:
			timer += delta
			#print(timer)
		
		#Diminuir timer para um timing mais apertado para acertar a bola:
		if timer >= 0.2:
			Point()
