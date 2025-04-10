extends TextureRect

@onready var animation_player = $AnimationPlayer
var menu = preload("res://scenes/introStartup/second_scene.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func on_animation_disappear_finished():
	get_tree().change_scene_to_packed(menu);

func playAnimationAppear():
	animation_player.play("appear");
	
func playAnimationDisappear():
	animation_player.play("disappear");
