extends Sprite2D

@onready var hurt_component = $HurtComponent
@onready var damage_component = $DamageComponent

var log_scene = preload("res://scenes/objects/tree/log.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int):
	print ("HIT")
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensivity", 1.0)
	print(material.get_shader_parameter("shake_intensivity"))
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensivity", 0.0)
	print ("timeout")
	print(material.get_shader_parameter("shake_intensivity"))

func  on_max_damage_reached():
	call_deferred("add_log_scene")
	print ("MAX DMG REACHED")
	queue_free()

func add_log_scene():
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
