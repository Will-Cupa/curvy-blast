extends StaticBody2D

var player

var playerInCanon = false
var expression = Expression.new()
var expressionReady = false
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func parseFunc(text : String) -> bool:
	#Transformer le texte en expression préparée
	var parsable = expression.parse(text,["x"])
	
	#verifier que le texte saisie est bien une fonction en maths
	if parsable == OK :
		var _result = expression.execute([0]) #tester la fonction 
		if !expression.has_execute_failed(): #verifier qu'elle s'execute bien
			return true
			
	return false

func _on_line_edit_text_submitted(_text : String) -> void: #appel quand le joueur valide sa saisie
	if expressionReady && playerInCanon:
		player.shoot(expression) #On lance le joueur
		
func _on_line_edit_text_changed(new_text: String) -> void: #appel quand le joueur saisi quelque chose
	expressionReady = parseFunc(new_text)
	queue_redraw()

func _on_area_2d_body_entered(body : Object) -> void:
	#On verifie que l'objet qui entre est le joueur
	if body is Player:
		player = body #On garde la reference
		player.enterCanon(position.x,position.y)
		playerInCanon = true #Le joueur est dans le canon

func slopeAt(x : float, precision : float) -> float:
	if player != null:
		return (valueAt(x + precision) -valueAt(x))/precision
	return 0.0

func valueAt(x : float) -> float:
	if expressionReady && player != null:
		return -expression.execute([x/player.XYScale])*player.XYScale
	return 0.0


func getOptiPoint(x1, space, treshold) -> float:
	print(space)
	var x2 = x1 + space
	var x3 = x1 + space/2
	var y1 = valueAt(x1)
	var y2 = valueAt(x2)
	var y3 = min(y1, y2) + abs(y1 - y2)/2
	var yTarget = valueAt(x3)
	
	if abs(y3 - yTarget) > treshold && space > 1:
		return getOptiPoint(x1, space/2, treshold)
	return x2

func _draw() -> void:
	var space = 50
	var maxWidth = get_viewport_rect().size.x - position.x
	var p1
	var p2
	var i = 0
	var i2
	var nbPoints = 1
	if expressionReady:
		while i <= maxWidth:
			p1 = Vector2(i, valueAt(i)) 
			i2 = getOptiPoint(i, space, 0.1)
			p2 = Vector2(i2, valueAt(i2))
			i = i2
			nbPoints += 1
			draw_line(p1,p2,Color.RED,1)
			#sprite.rotation = slopeAt(0,0.1)
			#print(slopeAt(0,0.1))
		print(nbPoints)
