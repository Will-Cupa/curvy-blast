extends Node2D

var total_colletable = 0
const MAX_COLLECTABLE = 3

signal colectable_collected(value : int)

func collect_collectable(value: int):
	total_colletable += value
	total_colletable = min(MAX_COLLECTABLE, total_colletable)
	print(total_colletable)
	self.emit_signal("colectable_collected", total_colletable)
