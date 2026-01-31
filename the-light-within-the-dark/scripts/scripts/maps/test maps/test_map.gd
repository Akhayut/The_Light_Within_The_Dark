extends Node2D

var room2Pos = Vector2(-320, 0)

func _ready():
	# Hides the cursor and prevents it from leaving the game window (for camera controls)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	Input.warp_mouse(Vector2(200,-150))
	print("hello")
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($playerCam, "position", room2Pos, 0.5)
	warp_mouse_to_player($bangleBerry)
	
	
func warp_mouse_to_player(player: Node2D):
	var vp := get_viewport()        # the actual viewport
	var cam: Camera2D = vp.get_camera_2d()
	if cam == null:
		print("No Camera2D found!")
		return

	# Step 1: world -> camera local
	var cam_local: Vector2 = cam.global_transform.affine_inverse() * player.global_position

	# Step 2: apply camera zoom
	var zoomed: Vector2 = cam_local * cam.zoom

	# Step 3: add camera offset (convert vp.size to Vector2)
	var screen_pos: Vector2 = zoomed + Vector2(vp.size) / 2

	# Step 4: warp mouse
	vp.warp_mouse(screen_pos)

	print("Warped mouse to screen position: ", screen_pos)
