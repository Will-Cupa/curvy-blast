extends Node2D

@onready var canon: StaticBody2D = $TileMap/canon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canon.setScale(PI*50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
