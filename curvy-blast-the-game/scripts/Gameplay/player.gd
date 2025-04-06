class_name Player extends CharacterBody2D

@onready var animation: Node2D = $AnimationManager
@onready var hitBoxPatte = $CollisionShape2D2

signal death

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const CANON_VELOCITY = 3

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
		show()

func enterCanon(x,y):
	inCanon = true
	canoned = false
	position.x = x
	position.y = y
	#ajouter l'apparition de l'interface
	xRelatif = 0
	yRelatif = 0
	yAvantCanon = position.y
	velocity = Vector2(0,0)
	hide()

func applyCanonMov(delta):
	
	xRelatif += CANON_VELOCITY
	var res = calculeCurve()
	if res != null:
		yRelatif = res

	var new_y = yAvantCanon + yRelatif
	var new_velocity = Vector2(CANON_VELOCITY / delta, (new_y - position.y) / delta)
	velocity = new_velocity

	var collision = move_and_collide(velocity * delta)
	if collision:
		checkDeath(collision)
		print(collision)
		canoned = false


func animationGestion():
	if(inCanon):
		animation.play("inCanon")
		
	elif(canoned):
		animation.play("enVol")
		animation.rotation = atan(functionCurve.slopeAt(xRelatif, 0.1))+PI/2
		
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
			
func checkDeath(collision = null):
	if(collision != null):
		print("ok")
		var body = collision.get_collider()
		if body is TileMap:
			print("ok")
			var tilemap = body
			var collision_position = collision.get_position()
			var cell = tilemap.local_to_map(collision_position)
			
			var layer_id = 1  # Remplacez par l'index de la couche
			print(collision_position)
			var tile_data = tilemap.get_cell_tile_data(layer_id, cell)
			if tile_data:
				print("ok")
				if tile_data.get_collision_polygons_count(0) > 0:
					print("tu es mort")
					#death.emit()
					get_tree().reload_current_scene()
	
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
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
					#death.emit()
					get_tree().reload_current_scene()
					


func _physics_process(delta):
	
	animationGestion()
	checkDeath()
	
	if(inCanon):
		pass
		
	elif(canoned):
		applyCanonMov(delta)
		hitBoxPatte.disabled = true
		
	else:
		hitBoxPatte.disabled = false
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
			
			if(direction < 0):
				animation.flip_v
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
