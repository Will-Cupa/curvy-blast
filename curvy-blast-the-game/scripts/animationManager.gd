extends Node2D

@onready var outline = $outline
@onready var body = $body

func play(name):
	if get_animation() != name:
		body.play(name)
		outline.play(name)

func play_backwards(name):
	if get_animation() != name:
		body.play_backwards(name)
		outline.play_backwards(name)

func flip_v():
	body.flip_v()
	outline.flip_v()

func get_animation():
	return body.get_animation()
