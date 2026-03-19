extends StaticBody2D
const scale_ball = Vector2(0.010,0.010)
@onready var max_scale = scale
#Vector2(1.5,1.5)
const min_scale = Vector2(0.3,0.3)
@onready var Ball = $Area2D
var Speed = 1
var on_hit = false
var child_exists: bool = false
var Lado = "meio"

func _ready() -> void:
	remove_child(Ball)
	child_exists = false
	#await get_tree().create_timer(1).timeout
	#add_child(Ball)

func _process(_delta: float) -> void:
	Move()
	Grow()

func Grow():
	#Quando a bola é acertada:
	if on_hit == true:
		if child_exists == true:
			remove_child(Ball)
			child_exists = false
		scale -= scale_ball
		
		if scale <= min_scale:
			Lado = "Meio"
			on_hit = false		
			
	elif on_hit == false and scale <= max_scale:
		scale += scale_ball
		
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
