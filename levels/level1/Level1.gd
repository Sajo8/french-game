extends Node2D

func _ready():
	OS.set_window_maximized(true)
	# Set camera limit to the position of the last tile in the level
	$Player/Camera2D.limit_right = 1920
	
	$Player/Sprite.visible = false
	$Player/AnimatedSprite.visible = true
	$Player/CollisionShape2D.visible = true
	
	$Player/CollisionPolygon2D.disabled = true
	$Player/CollisionShape2D.disabled = false

	# Set spawn coords for the sublevel at the starting
	Globals.red_respawn_position = Vector2(320, 1900)
	# If they just died, then set spawn coords at the start
	if Globals.player_died:
		Globals.blue_respawn_position = Vector2(374, 677)
		Globals.player_died = false

	# Set the player position to newly assigned spawn coords
	var player = get_tree().get_nodes_in_group("player")
	if player:
		if Globals.blue_respawn_position != Vector2():
			player[0].position = Globals.blue_respawn_position

	if Globals.has_powerup("double_jump"):
		# Prevent the blue portal from doing anything if the player got double jump
		$BluePortal.enable_teleport = false
