class_name Camera extends Camera2D
@export var target : Node2D
@onready var pause_menu = $CanvasLayer/PauseMenu

var objectOffset : Vector2 #Offset from the canon

var menu_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setTarget(objet):
	target = objet

func setOffset(offset):
	objectOffset = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target != null):
		position = position.lerp(target.position + objectOffset, 0.1)
		
	if Input.is_action_just_pressed("ui_cancel"):
		if not pause_menu.visible:
			pause_menu.visible = true
			get_tree().paused = true
		else:
			pause_menu.visible = false
			get_tree().paused = false
