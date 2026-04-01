extends StaticBody2D
const Speed = 500
const direction = ["Meio", "Direita", "Esquerda"]

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
	pass

func move(delta:float) -> void:
	var ball_pos = $"../Ball/StaticBody2D".global_position
	var position = move_toward(global_position.x, ball_pos.x, delta * Speed)
	global_position.x = position


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player2"):
		$"../Ball/StaticBody2D".back_hit = true
		$"../Ball/StaticBody2D".Lado = direction.pick_random()
		print("Bola devolvida para: ", $"../Ball/StaticBody2D".Lado)
	pass # Replace with function body.
