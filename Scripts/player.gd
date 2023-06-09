extends CharacterBody2D

var speed = 200.0
var gravity = 20
var jump = 400

func _physics_process(delta):
	Move(delta)

	velocity.y += gravity
	move_and_slide()
	
func Move(delta): 
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0:
		if movement >  0.0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100, speed)
			$Sprite2D.flip_h = false
			$anim.play("Walk")
		
		if movement < 0.0:
			velocity.x -= speed * delta
			velocity.x = clamp(speed, -100, -speed)
			$Sprite2D.flip_h = true
			$anim.play("Walk")
	
	if movement == 0.0:
		velocity.x = 0.0
		$anim.play("Idle")
		
	if is_on_floor() && Input.is_action_just_pressed("ui_jump"):
		Jump()
		
	if !is_on_floor():
		$anim.play("Jump")
		
	if !is_on_floor() && velocity.y > 10:
		$anim.play("Fall")

func Jump():
	$anim.play("Jump")
	velocity.y -= jump
	
