class_name InteractibleComponent
extends Area2D

signal interctable_activated
signal interctable_deactivated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_exited(body:Node2D) -> void:
	interctable_deactivated.emit()

func _on_body_entered(body:Node2D) -> void:
	interctable_activated.emit()
