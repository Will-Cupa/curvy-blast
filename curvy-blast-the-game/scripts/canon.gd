extends StaticBody2D

var player

var playerInCanon = false
var expression = Expression.new()
var expressionReady = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func parseFunc(text : String) -> bool:
	#Transformer le texte en expression préparée
	var parsable = expression.parse(text,["x"])
	
	#verifier que le texte saisie est bien une fonction en maths
	if parsable == OK :
		var result = expression.execute([0]) #tester la fonction 
		if !expression.has_execute_failed(): #verifier qu'elle s'execute bien
			return true
			
	return false

func _on_line_edit_text_submitted(text : String) -> void: #appeler quand le joueur valide sa saisie
	if expressionReady && playerInCanon:
		player.shoot(expression) #On lance le joueur


func _on_area_2d_body_entered(body : Object) -> void:
	#On verifie que l'objet qui entre est le joueur
	if body is Player:
		player = body #On garde la reference
		player.enterCanon(position.x,position.y)
		playerInCanon = true #Le joueur est dans le canon


func _draw() -> void:
	var space = 1
	if expressionReady && player != null:
		var p1
		var p2
		for i in range(1000):
			p1 = Vector2(i*space, -expression.execute([(i*space)/player.XYScale])*player.XYScale) 
			p2 = Vector2((i+1)*space, -expression.execute([((i+1)*space)/player.XYScale])*player.XYScale)
			
			draw_line(p1,p2,Color.RED,1)


func _on_line_edit_text_changed(new_text: String) -> void:
	expressionReady = parseFunc(new_text)
	queue_redraw()
