class_name Canon extends StaticBody2D

var player
var playerInCanon = false
var expression = mathFunction.new()
var expressionReady = false
@onready var sprite = $canonNormal
@onready var inputField = $LineEdit

var camera
@export var cameraOffset : Vector2
@export var focusCam : bool = true
@export var startCanon : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	inputField.visible = false
	camera = get_viewport().get_camera_2d()
	if(startCanon):
		camera.setTarget(self)
		camera.setOffset(cameraOffset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func parseFunc(text : String) -> bool:
	#Transformer le texte en expression préparée
	var parsable = expression.parse(text,["x"])
	
	#verifier que le texte saisie est bien une fonction en maths
	if parsable == OK :
		var _result = expression.execute([0.001]) #tester la fonction 
		if !expression.has_execute_failed(): #verifier qu'elle s'execute bien
			return true
	return false

func _on_line_edit_text_submitted(_text : String) -> void: #appel quand le joueur valide sa saisie
	if expressionReady && playerInCanon:
		player.shoot(expression) #On lance le joueur
		playerInCanon = false
		inputField.visible = false
		queue_redraw()
		
func _on_line_edit_text_changed(new_text: String) -> void: #appel quand le joueur saisi quelque chose
	expressionReady = parseFunc(new_text)
	print(new_text)
	queue_redraw()

func _on_area_2d_body_entered(body : Object) -> void:
	#On verifie que l'objet qui entre est le joueur
	if body is Player:
		inputField.visible = true #afficher la barre de saisie
		player = body #On garde la reference
		player.enterCanon(position.x,position.y)
		
		#set camera
		if(focusCam):
			camera.setTarget(self)
			camera.setOffset(cameraOffset)
		
		inputField.grab_focus()
		playerInCanon = true #Le joueur est dans le canon
		queue_redraw()

func getOptiPoint(x1, space, treshold) -> float:
	print(space)
	var x2 = x1 + space
	var x3 = x1 + space/2
	var y1 = expression.valueAt(x1)
	var y2 = expression.valueAt(x2)
	var y3 = min(y1, y2) + abs(y1 - y2)/2
	var yTarget = expression.valueAt(x3)
	
	if abs(y3 - yTarget) > treshold && space > 1:
		return getOptiPoint(x1, space/2, treshold)
	return x2

func _draw() -> void:
	if playerInCanon:
		drawScale()
		if expressionReady:
			drawCurve()

func drawCurve():
	var space = 50
	var maxWidth = get_viewport_rect().size.x
	var p1
	var p2
	var i = 0
	var i2
	while i <= (40*expression.getXYScale()):
		p1 = Vector2(i, expression.valueAt(i)) 
		i2 = getOptiPoint(i, space, 0.1)
		p2 = Vector2(i2, expression.valueAt(i2))
		i = i2
		draw_line(p1,p2,Color.WHITE,2)
		sprite.rotation = atan(expression.slopeAt(0,0.1))
		sprite.position.y = expression.valueAt(0)

func drawScale():
	var default_font : Font = ThemeDB.fallback_font;	
	
	for n in range(40):
		draw_string(default_font, Vector2(n*expression.getXYScale(),0), str(n), HORIZONTAL_ALIGNMENT_LEFT, 32, 16, Color.WHITE)
		draw_string(default_font, Vector2(0,-n*expression.getXYScale()), str(n), HORIZONTAL_ALIGNMENT_LEFT, 32, 16, Color.WHITE)

func setScale(scale):
	expression.XYScale = scale
