extends CanvasLayer

class_name HUD

#player character reference variable
@onready var play_char : PlayerCharacter = $".."
@onready var wpn_holder : Node = $"../Weapon"

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
@onready var Attack_Mode_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/AttackModeLabelText
@onready var Level_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/LevelLabelText
@onready var Reloading_Label_Text: Label = $MarginContainer3/PanelContainer/PlayCharInfos2/VBoxContainer2/ReloadingLabelText3


func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("dev"):
		if %HUD.visible == true:
			%HUD.visible = false
		else :
			%HUD.visible = true
	display_current_FPS()
	
	display_properties()
	
	player2controls()
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
	Attack_Mode_Label_Text.set_text(str(wpn_holder.current_weapon))
	Level_Label_Text.set_text(str(wpn_holder.level))
	Reloading_Label_Text.set_text(str(play_char.reloading))

	
func display_current_FPS() -> void:
	if play_char.player_id == 1:
		frames_per_second_label_text.set_text(str(Engine.get_frames_per_second()))
	elif play_char.player_id == 2:
		$MarginContainer2.hide()
	
func round_to_3_decimals(value: float) -> float:
	return round(value * 1000.0) / 1000.0


func player2controls():
	if play_char.player_id == 2:
		current_state_label_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/CurrentStateLabelText
		desired_move_speed_label_text =$MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/DesiredMoveSpeedLabelText
		velocity_label_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/VelocityLabelText
		velocity_vector_label_text= $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/VelocityVectorLabelText
		is_on_floor_label_text= $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/IsOnFloorLabelText
		ceiling_check_label_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/CeilingCheckLabelText
		jump_buffer_label_text =$MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/JumpBufferLabelText
		coyote_time_label_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/CoyoteTimeLabelText
		nb_jumps_in_air_allowed_label_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/NbJumpsInAirAllowedLabelText
		jump_cooldown_label_text =$MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/JumpCooldownLabelText
		Gravity_Air_level_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/GravityAirLabelText
		Gravity_Jump_level_text = $MarginContainer4/PanelContainer/PlayCharInfos/VBoxContainer3/GravityJumpLabelText
		Can_Attack_Label_Text = $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/CanAttackLabelText
		Health_Label_Text = $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/HealthLabelText
		Times_Died_Label_Text = $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/TimesDiedLabelText
		Attack_Mode_Label_Text= $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/AttackModeLabelText
		Level_Label_Text= $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/LevelLabelText
		Reloading_Label_Text = $MarginContainer5/PanelContainer/PlayCharInfos2/VBoxContainer3/ReloadingLabelText3
		$MarginContainer3.hide()
		$MarginContainer2.hide()
		$MarginContainer.hide()
	elif  play_char.player_id == 1:
		$MarginContainer4.hide()
		$MarginContainer5.hide()
