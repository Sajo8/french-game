extends Node2D

func _ready():
	OS.set_window_maximized(true)
	# Set camera limit to the position of the bottom-most tile in the level
	$Player/Camera2D.limit_bottom = 1080
	$Player/Camera2D.limit_right = 4400

	$Player/Sprite.visible = true
	$Player/AnimatedSprite.visible = false
	$Player/CollisionShape2D.visible = false

	$Player/CollisionPolygon2D.disabled = false
	$Player/CollisionShape2D.disabled = true

	# If they just died, then set spawn coords at the start
	if Globals.player_died:
		Globals.red_respawn_position = Vector2(450, 2000)
		Globals.player_died = false

	# Set the player position to newly assigned spawn coords
	var player = get_tree().get_nodes_in_group("player")
	if player:
		if Globals.red_respawn_position != Vector2():
			player[0].position = Globals.red_respawn_position

	# Disable the teleportation of the portal which takes you to the quiz if they already have double jump
	if Globals.has_powerup("double_jump"):
		$QuizPortal.enable_teleport = false


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.fingerprint()
	yield(get_tree().create_timer(1), "timeout")
	$Fingerprint/Sign/scannerOff.visible = false
	$Fingerprint/Sign/scannerOn.visible = true

	$Fingerprint/Area2D/CollisionShape2D.disabled = true
	$Fingerprint/AnimationPlayer.play("fade_in")
	yield($Fingerprint/AnimationPlayer, "animation_finished")
	body.set_physics_process(true)

func _on_Area2DEnd_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.endGame()
