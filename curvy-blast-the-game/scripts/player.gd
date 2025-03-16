class_name Player extends CharacterBody2D

@onready var animation: Node2D = $AnimationManager

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const CANNON_VELOCITY = 3
var XYScale : float = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var canoned = false
var inCanon = false 
var functionCurve #Expression
var xRelatif = 0
var yRelatif = 0
var yAvantCanon = 0

func calculeCurve():
	var result = functionCurve.valueAt(xRelatif)
	if not functionCurve.has_execute_failed():
		#print(result)
		return result

func shoot(f):
	if(inCanon):
		canoned = true
		inCanon = false
		
		functionCurve = f
		#changer d'annimation

func enterCanon(x,y):
	inCanon = true
	canoned = false
	position.x = x
	position.y = y
	#ajouter l'apparition de l'interface
	xRelatif = 0
	yRelatif = 0
	yAvantCanon = position.y

func applyCanonMov(delta):
	
	position.x += CANNON_VELOCITY
	xRelatif += CANNON_VELOCITY
	var res = calculeCurve()
	if (res != null):
		yRelatif = res
		position.y = yAvantCanon + yRelatif
	var collision = move_and_collide(velocity * delta,true)
	if (collision):
		canoned = false

func animationGestion():
	if(inCanon):
		animation.play("inCanon")
		
	elif(canoned):
		animation.play("enVol")
		animation.rotation = atan(functionCurve.slopeAt(position.x, 0.1))
		
	else:
		animation.rotation = 0
		if is_on_floor():
			if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
				animation.play("walk")
			elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
				animation.play_backwards("walk")
			else:
				animation.play("idle")
			
		else:
			if velocity.y < 0:
				animation.play("jump")
			else:
				animation.play("fall")
			
func checkDeath():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is TileMap:
			var tilemap = body
			var collision_position = collision.get_position()
			var cell = tilemap.local_to_map(collision_position)
			
			var layer_id = 1  # Remplacez par l'index de la couche
			var tile_data = tilemap.get_cell_tile_data(layer_id, cell)
			if tile_data:
				if tile_data.get_collision_polygons_count(0) > 0:
					print("tu es mort")


func _physics_process(delta):
	
	animationGestion()
	checkDeath()
	
	if(inCanon):
		pass
		
	elif(canoned):
		applyCanonMov(delta)
		
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			
			if(direction < 0):animation.flip_v
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
