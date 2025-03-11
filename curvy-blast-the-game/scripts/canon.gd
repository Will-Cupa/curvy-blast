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

func parseFunc(text):
	#verifier que le texte saisie est bien une fonction en maths
	var parsable = expression.parse(text,["x"])
	
	if parsable == OK :
		var result = expression.execute([0])
		if !expression.has_execute_failed():
			return expression
			
	return null

func _on_line_edit_text_submitted(text):
	print("send")
	var f = parseFunc(text)
	print(f)
	player.shoot(f) #On lance le joueur


func _on_area_2d_body_entered(body):
	#On verifie que l'objet qui entre est le joueur
	if body is Player:
		player = body #On garde la reference
		player.enterCanon(position.x,position.y)
		playerInCanon = true #Le joueur est dans le canon
