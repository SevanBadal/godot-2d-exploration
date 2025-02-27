extends CharacterBody2D

const MAX_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized() # vector of length one
	velocity = direction * MAX_SPEED
	move_and_slide()
	if Input.get_action_strength("hello_summer") == 1:
		print("Hello Summer")


func get_movement_vector():	
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
