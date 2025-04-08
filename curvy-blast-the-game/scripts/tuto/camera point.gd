extends Node2D

var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_viewport().get_camera_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		camera.setTarget(self)
