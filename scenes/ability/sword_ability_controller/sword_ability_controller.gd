extends Node

const MAX_RANGE = 150
# Which scene to spawn at runtime
@export var sword_ability: PackedScene
var base_wait_time

var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvent.ability_upgrade_added.connect(on_ability_upgrade_added)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy") as Array[Node2D]
	if enemies.size() == 0:
		return
		
	var closest_enemy: Node2D = enemies.reduce(
		func(closest: Node2D, current: Node2D):
			var closest_dist = closest.global_position.distance_squared_to(player.global_position)
			var current_dist = current.global_position.distance_squared_to(player.global_position)
			return closest if closest_dist < current_dist else current
	) as Node2D
	
	# Now check if closest enemy is within range
	if closest_enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2):
		var sword_instance = sword_ability.instantiate() as SwordAbility
		var entities_layer = get_tree().get_first_node_in_group("foreground_layer")

		entities_layer.add_child(sword_instance)
		sword_instance.hitbox_component.damage = damage
		sword_instance.global_position = closest_enemy.global_position
		# set random direction, not really doing anything since I'm tracking direction of the enemy in sword ability. Good for following effect and direction effect
		sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0,TAU))
		if sword_instance.has_method("set_target_enemy"):
			sword_instance.set_target_enemy(closest_enemy)

func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
