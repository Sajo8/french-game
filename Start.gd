extends Node2D

func _ready() -> void:
	OS.set_window_maximized(true)

func _physics_process(delta: float) -> void:
	if $Camera2D.zoom <= Vector2(0, 0):
		get_tree().change_scene("res://levels/level1/Level1.tscn")
	else:
		$Camera2D.zoom.x -= 0.003
		$Camera2D.zoom.y -= 0.003
