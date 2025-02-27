extends Node2D
# TODO make sword extend character body 2d to allow move and slide!

var target_enemy: Node2D = null
var max_speed = 75


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

# will use with velocity later
func getDirectionToEnemy():
	if target_enemy == null:
		return Vector2.ZERO
	return (target_enemy.global_position - global_position).normalized()
