extends Node2D

var pressed = false

func _ready() -> void:
	OS.set_window_maximized(true)
	OS.window_fullscreen = true

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		pressed = true
	if not pressed:
		return
	if $Camera2D.zoom <= Vector2(0, 0):
		get_tree().change_scene("res://levels/level1/Level1.tscn")
	else:
		$Camera2D.zoom.x -= 0.003
		$Camera2D.zoom.y -= 0.003
