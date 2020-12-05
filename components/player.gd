extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
export var max_speed = 200
export var gravity = 20
export var acceleration = 50
export var friction = 0.2
export var jump_force = 550

func _physics_process(_delta):
	var has_friction = false
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + acceleration, max_speed)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - acceleration, -max_speed)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		has_friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jump_force
		if has_friction == true:
			motion.x = lerp(motion.x, 0, friction)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if has_friction == true:
			motion.x = lerp(motion.x, 0, friction * 0.25)
	
	motion = move_and_slide(motion, UP)
	pass
