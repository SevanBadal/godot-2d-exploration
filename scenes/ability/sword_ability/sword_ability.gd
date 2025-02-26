extends Node2D

var target_enemy: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(target_enemy):
		var enemy_direction = target_enemy.global_position - global_position
		rotation = enemy_direction.angle()
		global_position = global_position.lerp(target_enemy.global_position, 10.0 * delta) 

func set_target_enemy(enemy: Node2D):
	target_enemy = enemy
