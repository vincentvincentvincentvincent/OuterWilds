extends State

class_name StunState

var state_name : String = "Stun"

var play_char : CharacterBody3D

var stun_amount :int = 8
var stun_input_counter:int =0
var can_transition :bool = false
func enter(play_char_ref : CharacterBody3D) -> void:
	play_char = play_char_ref
	play_char.can_attack = false
	verifications()
	print("stun")
	can_transition = false
	stun_input_counter = 0
	play_char.velocity.x = lerp(1, 1, 1)

func verifications() -> void:
	play_char.move_speed = 1
	play_char.move_accel = 1
	play_char.move_deccel = 1
	 
	play_char.floor_snap_length = 1.0
	if play_char.jump_cooldown > 0.0: play_char.jump_cooldown = -1.0
	if play_char.nb_jumps_in_air_allowed < play_char.nb_jumps_in_air_allowed_ref: play_char.nb_jumps_in_air_allowed = play_char.nb_jumps_in_air_allowed_ref
	if play_char.coyote_jump_cooldown < play_char.coyote_jump_cooldown_ref: play_char.coyote_jump_cooldown = play_char.coyote_jump_cooldown_ref
	
	play_char.tween_hitbox_height(play_char.base_hitbox_height)
	play_char.tween_model_height(play_char.base_model_height)
	
func physics_update(delta : float) -> void:
	applies(delta)
	
	play_char.gravity_apply(delta)
	
	input_management()
	
	move(delta)
	stunremover()
	check_stun_count()

func applies(delta : float) -> void:
	if play_char.hit_ground_cooldown > 0.0: play_char.hit_ground_cooldown -= delta
	
	if !play_char.is_on_floor() and can_transition == true:
		if play_char.velocity.y < 0.0:
			transitioned.emit(self, "InairState")
			
	if play_char.is_on_floor() and can_transition == true:
		$"../..".fall_gravity = (-2.0 * play_char.jump_height) / (play_char.jump_time_to_fall * play_char.jump_time_to_fall)
		#check if can auto bunny hop
		if play_char.auto_bunny_hop and play_char.hit_ground_cooldown > 0.0 and play_char.input_direction != Vector2.ZERO and play_char.jump_cooldown < 0.0:
			transitioned.emit(self, "JumpState")
		if play_char.jump_buff_on and play_char.jump_cooldown < 0.0:
			#apply jump buffering
			play_char.buffered_jump = true
			play_char.jump_buff_on = false
			transitioned.emit(self, "JumpState")
	
func input_management() -> void:
	if Input.is_action_just_pressed(play_char.jump_action) and can_transition == true:
		if play_char.jump_cooldown < 0.0:
			transitioned.emit(self, "JumpState")
		
	if Input.is_action_just_pressed(play_char.crouch_action) and can_transition == true:
		transitioned.emit(self, "CrouchState")
		
	if Input.is_action_just_pressed(play_char.run_action) and can_transition == true:
		play_char.walk_or_run = "RunState"
		transitioned.emit(self, "RunState")
	if Input.is_action_just_pressed(play_char.stun_action) and can_transition == true:
		transitioned.emit(self, "StunState")
		
func move(delta : float) -> void:
	play_char.input_direction = Input.get_vector(play_char.move_left_action, play_char.move_right_action, play_char.move_forward_action, play_char.move_backward_action)
	play_char.move_direction = (play_char.cam_holder.global_basis * Vector3(play_char.input_direction.x*0.1, 0.0, play_char.input_direction.y*0.1)).normalized()
	
	play_char.desired_move_speed = clamp(play_char.desired_move_speed, 0.0, play_char.max_desired_move_speed)
	
	if play_char.move_direction and play_char.is_on_floor():
		#apply smooth move
		play_char.velocity.x = lerp(play_char.velocity.x, play_char.move_direction.x * play_char.move_speed, play_char.move_accel * delta)
		play_char.velocity.z = lerp(play_char.velocity.z, play_char.move_direction.z * play_char.move_speed, play_char.move_accel * delta)
		
		if play_char.hit_ground_cooldown <= 0: play_char.desired_move_speed = play_char.velocity.length()
		
	elif can_transition == true:
		transitioned.emit(self, "IdleState")
	
	
func stunremover():

	if Input.is_action_just_pressed("play_char_attack_action") or Input.is_action_just_pressed("play_char_crouch_action") or Input.is_action_just_pressed("play_char_jump_action") or Input.is_action_just_pressed("play_char_move_backward_action") or Input.is_action_just_pressed("play_char_move_forward_action"):
		stun_input_counter += 1


func check_stun_count():
	if stun_input_counter >= stun_amount:
		can_transition=true
