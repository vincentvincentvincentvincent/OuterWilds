extends CharacterBody3D

class_name PlayerCharacter

@export_group("multiplayer")
@export var player_id = 1

@export_group("Movement variables")
var move_speed: float
var move_accel: float
var move_deccel: float
var input_direction: Vector2
var move_direction: Vector3
var desired_move_speed: float
@export var desired_move_speed_curve: Curve #accumulated speed
@export var max_desired_move_speed: float = 30.0
@export var in_air_move_speed_curve: Curve
@export var hit_ground_cooldown: float = 0.1 #amount of time the character keep his accumulated speed before losing it (while being on ground)
var hit_ground_cooldown_ref: float
@export var bunny_hop_dms_incre: float = 3.0 #bunny hopping desired move speed incrementer
@export var auto_bunny_hop: bool = false
var last_frame_position: Vector3
var last_frame_velocity: Vector3
var was_on_floor: bool
var walk_or_run: String = "WalkState" #keep in memory if play char was walking or running before being in the air
#for states that require visible changes of the model
@export var base_hitbox_height: float = 1.4
@export var base_hitbox_head_height: float = 1.4
@export var base_model_height: float = 0.85
@export var height_change_duration: float = 0.15

@export_group("Crouch variables")
@export var crouch_speed: float = 6.0
@export var crouch_accel: float = 12.0
@export var crouch_deccel: float = 11.0
@export var continious_crouch: bool = false #if true, doesn't need to keep crouch button on to crouch
@export var crouch_hitbox_height: float = 0.8
@export var crouch_hitbox_head_height: float = 0.2
@export var crouch_model_height: float = 0.6

@export_group("Walk variables")
@export var walk_speed: float = 9.0
@export var walk_accel: float = 11.0
@export var walk_deccel: float = 10.0

@export_group("Run variables")
@export var run_speed: float = 12.0
@export var run_accel: float = 10.0
@export var run_deccel: float = 9.0
@export var continious_run: bool = false #if true, doesn't need to keep run button on to run

@export_group("Jump variables")
@export var jump_height: float = 2.0
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_fall: float = 0.25
@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@export var jump_cooldown: float = 0.25
var jump_cooldown_ref: float
@export var nb_jumps_in_air_allowed: int = 1
var nb_jumps_in_air_allowed_ref: int
var jump_buff_on: bool = false
var buffered_jump: bool = false
@export var coyote_jump_cooldown: float = 0.3
var coyote_jump_cooldown_ref: float
var coyote_jump_on: bool = false

@export_group("Gravity variables")
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_fall * jump_time_to_fall)



@export_group("Combat variables")
@export var can_attack: bool = false
@export var health: float = 100
@export var times_died: float = 0

#references variables
@onready var cam_holder: Node3D = %CameraHolder
@onready var model: MeshInstance3D = %Model
@onready var hitbox: CollisionShape3D = %Hitbox_body
@onready var hitbox_head: CollisionShape3D = %Hitbox_head
@onready var state_machine: StateMachine = %StateMachine
@onready var hud: CanvasLayer = %HUD
@onready var ceiling_check: RayCast3D = %CeilingCheck
@onready var floor_check: RayCast3D = %FloorCheck



func _ready() -> void:
	#set and value references
	hit_ground_cooldown_ref = hit_ground_cooldown
	jump_cooldown_ref = jump_cooldown
	jump_cooldown = -1.0
	nb_jumps_in_air_allowed_ref = nb_jumps_in_air_allowed
	coyote_jump_cooldown_ref = coyote_jump_cooldown

#double tap
var hold_timer = 0.0
var is_holding = false
var last_action = ""
var doubletap_timer = 0.0
const DOUBLETAP_DELAY = 0.3

func check_doubletap(action: String):
	if last_action == action and doubletap_timer > 0:
		Input.action_press("play_char_run_action_%s" %[player_id])
		# Reset after doubletap
		last_action = ""
		doubletap_timer = 0.0
	else:
		last_action = action
		doubletap_timer = DOUBLETAP_DELAY
		Input.action_release("play_char_run_action_%s" %[player_id])
func _process(delta):
	# Update timer
	if doubletap_timer > 0:
		doubletap_timer -= delta
	else:
		last_action = ""
		
	if Input.is_action_just_pressed("play_char_move_forward_action_%s" %[player_id]):
		check_doubletap("play_char_move_forward_action_%s" %[player_id])
	if Input.is_action_just_pressed("play_char_move_backward_action_%s" %[player_id]):
		check_doubletap("play_char_move_backward_action_%s" %[player_id])
	
	attack()


func health_checker():
	if health <=0:
		times_died += 1
		health = 100

func _physics_process(_delta: float) -> void:
	modify_physics_properties()
	#added this to prevent players from going behind shit collisions
	position.z = 0
	
	move_and_slide()
	look_direction()
	health_checker()
	reloadcontrol()

	
func modify_physics_properties() -> void:
	last_frame_position = global_position #get play char global position every frame
	last_frame_velocity = velocity #get play char velocity every frame
	was_on_floor = !is_on_floor() #check if play char was on floor every frame
	
func gravity_apply(delta: float) -> void:
	# if play char goes up, apply jump gravity
	#otherwise, apply fall gravity
	if not is_on_floor(): #no need to push play char if he's already on the floor
		if velocity.y >= 0.0: velocity.y += jump_gravity * delta
		elif velocity.y < 0.0: velocity.y += fall_gravity * delta
		
#use of 2 tweens to change the hitbox and model heights, relative to a specific state
func tween_hitbox_height(state_hitbox_height : float) -> void:
	var hitbox_tween: Tween = create_tween()
	if hitbox != null:
		hitbox_tween.tween_method(func(v): set_hitbox_height(v), hitbox.shape.height, 
		state_hitbox_height, height_change_duration)
	#to avoid "no tweeners" error
	else:
		hitbox_tween.tween_interval(0.1)
	hitbox_tween.finished.connect(Callable(hitbox_tween, "kill"))
	var hitbox_head_tween: Tween = create_tween()
	if hitbox_head != null:
		hitbox_head_tween.tween_method(func(v): set_hitbox_height(v), hitbox_head.shape.height, 
		state_hitbox_height, height_change_duration)
	#to avoid "no tweeners" error
	else:
		hitbox_head_tween.tween_interval(0.1)
	hitbox_head_tween.finished.connect(Callable(hitbox_head_tween, "kill"))

func set_hitbox_height(value: float) -> void:
	if hitbox.shape is CapsuleShape3D:
		hitbox.shape.height = value
	if hitbox_head.shape is CapsuleShape3D:
		hitbox_head.shape.height = value
func tween_model_height(state_model_height : float) -> void:
	var model_tween: Tween = create_tween()
	if model != null:
		model_tween.tween_property(model, "scale:y", 
		state_model_height, height_change_duration)
	#to avoid "no tweeners" error
	else:
		model_tween.tween_interval(0.1)
	model_tween.finished.connect(Callable(model_tween, "kill"))

func look_direction():
	if is_on_floor() and can_attack == true:
		if Input.is_action_just_pressed("play_char_move_forward_action_%s" %[player_id]):
			var rotate_forward_tween = create_tween()
			rotate_forward_tween.tween_property(%Model, "rotation:y", rotation.y + deg_to_rad(-180), 0.3)
			dir_fix = -0.05

		if Input.is_action_just_pressed("play_char_move_backward_action_%s" %[player_id]):
			var rotate_forward_tween = create_tween()
			rotate_forward_tween.tween_property(%Model, "rotation:y", rotation.y + deg_to_rad(0), 0.3)
			dir_fix = 0.055
			

var dir_fix = 0.05
signal  attacked(pos: Vector3, dir: Vector3)
signal attackheld()
var Firetimeout :bool = false
var reloading:bool = false
var shots_fired:int = 0
func attack():

	if Input.is_action_pressed("play_char_attack_action_%s" %[player_id]) and can_attack == true and Firetimeout == false and reloading == false:
		Firetimeout = true
		await get_tree().create_timer(Global.Fire_time).timeout
		attacked.emit($Model/Gun_Point.global_position, Vector3($Model/Gun_Point.rotation.x + dir_fix, $Model/Gun_Point.rotation.y, $Model/Gun_Point.rotation.z))
		shots_fired += 1
		await get_tree().create_timer(0.1).timeout
		attackheld.emit()
		print("held")
		Firetimeout = false
			
	if Input.is_action_just_pressed("play_char_attack_action_%s" %[player_id]) and can_attack == true and Firetimeout == false and reloading == false:
		Firetimeout = true
		attacked.emit($Model/Gun_Point.global_position, Vector3($Model/Gun_Point.rotation.x + dir_fix, $Model/Gun_Point.rotation.y, $Model/Gun_Point.rotation.z))
		shots_fired += 1
		await get_tree().create_timer(Global.Fire_time).timeout
		Firetimeout = false
		

func reloadcontrol():
	if shots_fired == Global.Clip_size:
		reloading = true
		await get_tree().create_timer(Global.Reload_time).timeout
		reloading = false
		shots_fired = 0
