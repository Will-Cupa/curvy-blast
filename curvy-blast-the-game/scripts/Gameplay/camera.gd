class_name Camera extends Camera2D
@export var target : Node2D
var objectOffset : Vector2 #Offset from the canon

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
