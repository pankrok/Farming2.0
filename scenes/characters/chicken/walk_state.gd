extends NodeState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent_2d: NavigationAgent2D;
@export var minimum_speed: float = 5.0
@export var maximum_speed: float = 10.0

var speed: float

func _ready():
	navigation_agent_2d.velocity_computed.connect(on_safe_velosity_computed)
	call_deferred("character_setup")

func character_setup():
	await get_tree().physics_frame

	set_movement_target()

func set_movement_target() -> void:
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(), navigation_agent_2d.navigation_layers, false)
	navigation_agent_2d.target_position = target_position
	speed = randf_range(minimum_speed, maximum_speed)
	

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		set_movement_target()
		return

	var target_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	animated_sprite_2d.flip_h = target_direction.x < 0

	var velocity: Vector2 = target_direction * speed
	if (navigation_agent_2d.avoidance_enabled):
		navigation_agent_2d.velocity = velocity
	else:
		character.velocity = velocity
		character.move_and_slide()

func on_safe_velosity_computed(save_velocity: Vector2) -> void:
	character.velocity = save_velocity
	character.move_and_slide()

func _on_next_transitions() -> void:
	if navigation_agent_2d.is_navigation_finished():
		character.velocity = Vector2.ZERO
		transition.emit("Idle")
	pass


func _on_enter() -> void:
	animated_sprite_2d.play("walk")
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
	pass
