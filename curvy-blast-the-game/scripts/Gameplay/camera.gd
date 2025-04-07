class_name Camera extends Camera2D
@export var target : Node2D
const PAUSE_MENU = preload("res://scenes/GameLevel/Menu/PauseMenu.tscn")
var objectOffset : Vector2 #Offset from the canon

var menuVisible = false
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
		if not menuVisible:
			menu_instance = PAUSE_MENU.instantiate()
			menu_instance.set_position(get_screen_center_position())
			add_child(menu_instance)
			menuVisible = true
		else:
			menu_instance.queue_free()
			menuVisible = false
	
	if menuVisible:
		menu_instance.set_position(get_screen_center_position())
