extends CharacterBody2D


const SPEED = 100.0
# const JUMP_VELOCITY = -1

# Define gravity for the player
var player_gravity = 800
var player_death = false
var flip_disabled = false
var check_ground = false

func _physics_process(delta):
	# restarts level
	if Input.is_action_just_pressed("input_restart"):
		get_tree().reload_current_scene()
		
	if player_death:
		return
		
	# Add the gravity to the player
	velocity.y += player_gravity * delta
	if check_ground == true:
		if is_on_ceiling() == true or is_on_floor() == true:
			flip_disabled = false
			check_ground = false
		# Handle gravity flip
	if Input.is_action_just_pressed("input_up") and flip_disabled == false:
		rotate(deg_to_rad(180))
		player_gravity *= -1

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func _on_area_2d_area_entered(area):
	flip_disabled = true
	if area.is_in_group("red_tile"):
		player_death = true
		$PlayerSprite.visible = false
		$PlayerDeathParticle.emitting = true
		velocity = Vector2(0, 0)
		$DeathTone.playing = true
	if area.is_in_group("lavender_tile"):
		rotate(deg_to_rad(180))
		player_gravity *= -1
	if area.is_in_group("piss_tile"):
		check_ground = false
	if area.is_in_group("goal_tile"):
		player_death = true
		velocity = Vector2(0, 0)
		$VictoryTone.playing = true
		
func _on_area_2d_area_exited(_area):
	check_ground = true
