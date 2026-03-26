extends StaticBody2D
const scale_ball = Vector2(0.010,0.010)
const bounce_speed = 1
@onready var max_scale = scale
#Vector2(1.5,1.5)
const min_scale = Vector2(0.1,0.1)
@onready var Ball = $Area2D
var Speed = 1
var on_hit = false
var child_exists: bool = false
var Lado = "meio"
var timer = 0.3
@onready var initial_pos = global_position
var going_in = true


func _ready() -> void:
	remove_child(Ball)
	child_exists = false
	#await get_tree().create_timer(1).timeout
	#add_child(Ball)

func _process(delta: float) -> void:
	Move()
	Grow(delta)
	

func Grow(delta):
	#Quando a bola é acertada:
	if on_hit == true:
		if child_exists == true:
			remove_child(Ball)
			going_in = true
			child_exists = false
		scale -= scale_ball
		Bounce(delta)
		
		if scale <= min_scale:
			Lado = "Meio"
			on_hit = false		
			
	elif on_hit == false and scale <= max_scale:
		scale += scale_ball
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

func Move():
	match Lado:
		"Direita":
			Speed = 1
			global_position.x += Speed
		"Esquerda":
			Speed = 1
			global_position.x -= Speed
		"Meio":
			Speed = 0	

func Bounce(delta):
	timer -= delta
	
	if going_in:
		global_position.y += bounce_speed
	
	else:
		global_position.y -= bounce_speed
	
	if timer <= 0:
		going_in = !going_in
		timer = 0.3
	
	pass
