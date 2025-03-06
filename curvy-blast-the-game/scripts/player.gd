extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const CANNON_VELOCITY = 2
var XYScale = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var expression = Expression.new()
var canoned = true
var inCanon = false 
var functionCurve  = "2*cos(x)+4"

func calcule(f):
	var error = expression.parse(f)
	if error != OK:
		#print(expression.get_error_text())
		return
	var result = expression.execute()
	if not expression.has_execute_failed():
		#print(result)
		return result

func shoot(f):
	if(inCanon):
		var error = expression.parse(f)
		if error == OK:
			canoned = true
			inCanon = false
			
			functionCurve = f
			
			#changer d'annimation
			
func enterCanon(x,y):
	inCanon = true
	canoned = false
	
	#ajouter l'apparition de l'interface
	#changer d'annimation

func applyCanonMov(delta):
	position.x += CANNON_VELOCITY
	var res = calcule(functionCurve.replace("x","("+str(position.x)+"/"+str(XYScale)+".0)"))
	if (res != null):
		position.y = -res*XYScale
	var collision = move_and_collide(velocity * delta,true)
	if (collision):
		canoned = false

func _physics_process(delta):
	if(inCanon):
		animation.play("inCanon")
		
	elif(canoned):
		applyCanonMov(delta)
		animation.play("enVol")
		
	else:
		animation.play("idle")
		
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			animation.play("fall")
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animation.play("jump")

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			animation.play("jump")
			if(direction < 0):animation.flip_v
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
