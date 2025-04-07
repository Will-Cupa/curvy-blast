extends Node2D

var total_colletable = 0

signal colectable_collected(value : int)

func collect_collectable(value: int):
	total_colletable += value
	print(total_colletable)
	self.emit_signal("colectable_collected", total_colletable)
