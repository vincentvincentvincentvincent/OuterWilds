extends CanvasLayer

class_name HUD

#player character reference variable
@onready var play_char : PlayerCharacter = $".."

#label references variables
@onready var current_state_label_text: Label = %CurrentStateLabelText
@onready var desired_move_speed_label_text: Label = %DesiredMoveSpeedLabelText
@onready var velocity_label_text: Label = %VelocityLabelText
@onready var velocity_vector_label_text : Label = %VelocityVectorLabelText
@onready var is_on_floor_label_text: Label = %IsOnFloorLabelText
@onready var ceiling_check_label_text: Label = %CeilingCheckLabelText
@onready var jump_buffer_label_text: Label = %JumpBufferLabelText
@onready var coyote_time_label_text: Label = %CoyoteTimeLabelText
@onready var nb_jumps_in_air_allowed_label_text: Label = %NbJumpsInAirAllowedLabelText
@onready var jump_cooldown_label_text: Label = %JumpCooldownLabelText
@onready var frames_per_second_label_text: Label = %FramesPerSecondLabelText
@onready var Gravity_Air_level_text: Label = %GravityAirLabelText
@onready var Gravity_Jump_level_text: Label = %GravityJumpLabelText
@onready var Can_Attack_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/CanAttackLabelText
@onready var Health_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/HealthLabelText
@onready var Times_Died_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/TimesDiedLabelText
func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("dev"):
		if %HUD.visible == true:
			%HUD.visible = false
		else :
			%HUD.visible = true
	display_current_FPS()
	
	display_properties()
	
func display_properties() -> void:
	#player character properties
	current_state_label_text.set_text(str(play_char.state_machine.curr_state_name))
	desired_move_speed_label_text.set_text(str(round_to_3_decimals(play_char.desired_move_speed)))
	velocity_label_text.set_text(str(round_to_3_decimals(play_char.velocity.length())))
	velocity_vector_label_text.set_text(str("[ ", round_to_3_decimals(play_char.velocity.x)," ", round_to_3_decimals(play_char.velocity.y)," ", round_to_3_decimals(play_char.velocity.z), " ]"))
	is_on_floor_label_text.set_text(str(play_char.is_on_floor()))
	ceiling_check_label_text.set_text(str(play_char.ceiling_check.is_colliding()))
	jump_buffer_label_text.set_text(str(play_char.jump_buff_on))
	coyote_time_label_text.set_text(str(round_to_3_decimals(play_char.coyote_jump_cooldown)))
	nb_jumps_in_air_allowed_label_text.set_text(str(play_char.nb_jumps_in_air_allowed))
	jump_cooldown_label_text.set_text(str(round_to_3_decimals(play_char.jump_cooldown)))
	Gravity_Air_level_text.set_text(str(round_to_3_decimals(play_char.fall_gravity)))
	Gravity_Jump_level_text.set_text(str(round_to_3_decimals(play_char.jump_gravity)))
	Can_Attack_Label_Text.set_text(str(play_char.can_attack))
	Health_Label_Text.set_text(str(play_char.health))
	Times_Died_Label_Text.set_text(str(play_char.times_died))

	
func display_current_FPS() -> void:
	frames_per_second_label_text.set_text(str(Engine.get_frames_per_second()))
	
func round_to_3_decimals(value: float) -> float:
	return round(value * 1000.0) / 1000.0
	
	
	
	
	
