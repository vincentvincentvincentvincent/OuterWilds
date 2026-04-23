class_name Player
extends CharacterBody3D

@onready var animations = $AnimatedSprite3D
@onready var state_machine = $State_Machine


# How fast the player moves in meters per second.
@export var speed = 5
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 20
@export var jump_impulse = 10
@export var dash_impulse = 5

var djumpcheck: bool = false
var target_velocity = Vector3.ZERO


#func _physics_process(delta):
	#var direction = Vector3.ZERO
#state machine animations
	#state_machine.process_physics(delta)
	
	#if Input.is_action_pressed("Right"):
		#direction.x += 1
	#if Input.is_action_pressed("Left"):
		#direction.x -= 1

	#if is_on_floor() and Input.is_action_just_pressed("Jump"):
		#target_velocity.y = jump_impulse
		#await get_tree().create_timer(0.1).timeout
		#djumpcheck = true
	
	#if djumpcheck ==true  and Input.is_action_just_pressed("Jump"):
		#target_velocity.y = target_velocity.y + jump_impulse
		#djumpcheck =false

	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.


	# Ground Velocity
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed

	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	#velocity = target_velocity
	#move_and_slide()

#func _process(delta: float) -> void:
	#state_machine.process_frame(delta)
