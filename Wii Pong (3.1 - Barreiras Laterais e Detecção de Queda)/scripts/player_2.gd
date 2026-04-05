extends StaticBody2D
const direction = ["Meio", "Direita", "Esquerda"]
@onready var ball = $"../Ball/StaticBody2D"
@onready var initial_pos = global_position
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)

func move(delta:float) -> void:
	if is_instance_valid(ball) and has_node("../Ball/StaticBody2D"):
		var ball_pos = ball.global_position
		var Speed = randf_range(50, 220)  #Valor base da velocidade do Player 2 = (50, 250)
		var position = move_toward(global_position.x, ball_pos.x, delta * Speed)
		global_position.x = position
	
	else:
		var Speed = 250
		var position = move_toward(global_position.x, initial_pos.x, delta * Speed)
		global_position.x = position

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player2"):
		$"../Ball/StaticBody2D".back_hit = true
		$"../Ball/StaticBody2D".Lado = direction.pick_random()
		print("Bola devolvida para: ", $"../Ball/StaticBody2D".Lado)
	pass # Replace with function body.
