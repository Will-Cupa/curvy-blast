extends Node2D

@onready var outline = $outline
@onready var body = $body

func play(name):
	body.play(name)
	outline.play(name)

func play_backwards(name):
	body.play_backwards(name)
	outline.play_backwards(name)

func flip_v():
	body.flip_v()
	outline.flip_v()
