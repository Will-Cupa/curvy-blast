extends StaticBody2D
const PLAYER = preload("res://scenes/player.tscn")
@onready var area_2d: Area2D = $Area2D

var objectInside = false
var obect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (objectInside):
		if(Input.is_action_pressed("ui_accept")):
			obect.shoot("2*cos(x)")
 


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entrer")
	if body is Player:
		body.enterCanon(position.x,position.y)
		obect = body
		objectInside = true
		print("ok")
