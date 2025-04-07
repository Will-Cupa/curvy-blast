extends Node2D

@onready var panneau = $"."

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var lines = (panneau.get_meta("lignes"))
		DialogManager.start_dialog(global_position, lines)
