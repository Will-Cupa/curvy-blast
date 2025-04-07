extends Node2D

@export var value : int = 1


func _on_area_2d_body_entered(body):
	if body is Player:
		get_parent().collect_collectable(value)
		self.queue_free()
