extends Area2D
@onready var Ball = $"../Ball/StaticBody2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("ball"):
		if Ball.on_hit == true:
			GlobalLabel.score2 += 1
			print("Ponto pro Jogador 2, Caiu para fora")
		
		else:
			GlobalLabel.score1 += 1
			print("Ponto pro Jogador 1, Caiu para fora")
		print(Ball.on_hit)
		await Ball.Respawn()
	
