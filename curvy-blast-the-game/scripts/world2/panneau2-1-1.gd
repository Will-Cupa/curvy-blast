extends Node2D


@export var lines : Array[String] = [
	"Salut, jeune crabe!",
	"Ici une simple affine ne sufira pas",
	"on va utiliser des fonctions complexe",
	"Test d'ecrire floor(x) dans le canon"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	DialogManager.start_dialog(global_position, lines)
