extends Node2D
var paused = false
@onready var menu = $"Pause Menu"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Pause()
	Pause_Menu()
	pass

func Pause():
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		paused = !paused

func Pause_Menu():
	if paused:
		menu.show()
	
	else:
		menu.hide()
