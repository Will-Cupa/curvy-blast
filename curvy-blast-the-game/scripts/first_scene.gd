extends Control

@onready var logo = $PanelContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	logo.playAnimationAppear();
