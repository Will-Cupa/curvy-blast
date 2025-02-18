extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var expression = Expression.new()
var cannoned = true

func calcule(f):
	var error = expression.parse(f)
	if error != OK:
		#print(expression.get_error_text())
		return
	var result = expression.execute()
	if not expression.has_execute_failed():
		return result

func shoot(f):
	var error = expression.parse(f)
	if error == OK:
		cannoned = true


func _physics_process(delta):
	
	
	if(cannoned):
		position.x += 1
		
		#var res = calcule(str(position.x) + "+2");
		var res = calcule("( ");
		if (res != null):
			position.y = res
		
		
		var collision = move_and_collide(velocity * delta,true)
		
		if (collision):
			cannoned = false
			print("ok")
			
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
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
