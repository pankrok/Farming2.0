extends Sprite2D

@onready var hurt_component = $HurtComponent
@onready var damage_component = $DamageComponent

var log_scene = preload("res://scenes/objects/tree/log.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int):
	damage_component.apply_damage(hit_damage)

func  on_max_damage_reached():
	call_deferred("add_log_scene")
	print ("MAX DMG REACHED")
	queue_free()

func add_log_scene():
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)