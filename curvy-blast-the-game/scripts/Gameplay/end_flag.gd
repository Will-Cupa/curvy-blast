extends AnimatableBody2D

@onready var win_timer: Timer = $winTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		win_timer.start()
		print("you win")



func _on_win_timer_timeout() -> void:
	#var total_collectable = get_parent().total_colletable
	#Global.collectables_by_level[Global.current_level] = total_collectable
	get_tree().change_scene_to_file("res://scenes/GameLevel/LevelManager/world_select.tscn")
