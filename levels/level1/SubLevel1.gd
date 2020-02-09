extends Node2D

func _ready():
	# Set camera limit to the position of the bottom-most tile in the level
	$Player/Camera2D.limit_bottom = 2175
	$Player/Camera2D.limit_top = 1080
	
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
