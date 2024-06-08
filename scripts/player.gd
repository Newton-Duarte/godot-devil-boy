extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const MAX_X_SPEED = 130.0
const X_ACCEL = 1000
const FRICTION = 700

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D
@onready var jump_sfx = $JumpSfx
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump_sfx.play()
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * X_ACCEL * delta
		velocity.x = clamp(velocity.x, -MAX_X_SPEED, MAX_X_SPEED)
		
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		$AnimatedSprite2D.play("idle")
	
	if not is_on_floor():
		sprite.play("jump")
	else:
		if velocity.x == 0:
			sprite.play("idle")
		else:
			sprite.play("run")

	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
