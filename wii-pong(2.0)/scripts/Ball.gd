extends StaticBody2D
const scale_ball = Vector2(0.005,0.005)
const max_scale = Vector2(1.5,1.5)
const min_scale = Vector2(0.3,0.3)
@onready var Ball = $Area2D
var on_hit = false
var child_exists: bool = false

func _ready() -> void:
	remove_child(Ball)
	child_exists = false
	#await get_tree().create_timer(1).timeout
	#add_child(Ball)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Grow()
	pass

func Grow():
	if Input.is_action_just_pressed("Hit"):
		if on_hit == true:
			on_hit = false
		else:
			on_hit = true
		
	if on_hit == true:
		if child_exists == true:
			remove_child(Ball)
			child_exists = false
		scale -= scale_ball
		
		if scale <= min_scale:
			on_hit = false		
			
	elif on_hit == false and scale <= max_scale:
		scale += scale_ball
		
	if scale >= max_scale:
		if child_exists == false:
			add_child(Ball)
			child_exists = true
		
			
