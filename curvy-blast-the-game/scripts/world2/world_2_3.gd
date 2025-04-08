extends Node2D

@onready var canon: StaticBody2D = $TileMap/canon
var total_colletable = 0
const MAX_COLLECTABLE = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canon.setScale(PI*50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal colectable_collected(value : int)

func collect_collectable(value: int):
	total_colletable += value
	total_colletable = min(MAX_COLLECTABLE, total_colletable)
	print(total_colletable)
	self.emit_signal("colectable_collected", total_colletable)
