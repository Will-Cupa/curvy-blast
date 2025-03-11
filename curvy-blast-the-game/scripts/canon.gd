extends StaticBody2D

var player

var playerInCanon = false
var expression = Expression.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func isParsable(text):
	#verifier que le texte saisie est bien une fonction en maths
	var parsable = expression.parse(text,["x"])
	if parsable == OK :
		var result = expression.execute([0])
		return !expression.has_execute_failed()
	else :
		return false

func _on_line_edit_text_submitted(text):
	print("send")
	var parsable = isParsable(text)
	#Si la fonction est valide, qu'on connait le jouer et qu'il est dans le canon
	if parsable && playerInCanon && player != null: 
		player.shoot(text) #On lance le joueur


func _on_area_2d_body_entered(body):
	#On verifie que l'objet qui entre est le joueur
	if body is Player:
		player = body #On garde la reference
		player.enterCanon(position.x,position.y)
		playerInCanon = true #Le joueur est dans le canon


