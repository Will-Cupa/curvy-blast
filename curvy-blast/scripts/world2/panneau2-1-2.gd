extends Node2D

@export var lines : Array[String] = [
	"Bravo!",
	"le floor rcupere la partie entiere d'un nombre",
	"maintenant essaye de tester des variantes pour passer le prochaine obstacle bon courage"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	DialogManager.start_dialog(global_position, lines)
