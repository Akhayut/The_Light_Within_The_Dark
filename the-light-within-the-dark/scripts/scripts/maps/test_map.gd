extends Node2D

var room2pos = Vector2(-320, 0)
var room1pos = Vector2(0,0)
var room3pos = Vector2(320, 0)
var room4pos = Vector2(320,-180)
var tableRoom = Vector2(0,-180)

var currentRoom = 1
var readyToMove
var inPrismArea = false
var inPuzzleRoom = false

func _ready():
	# Hides the cursor and prevents it from leaving the game window (for camera controls)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") && inPrismArea:
		var tween = create_tween()
		warp_mouse_to_player($bangleBerry)
		tween.tween_property($playerCam, "position", tableRoom, 0.5)
		inPuzzleRoom = true
		inPrismArea = false
	elif Input.is_action_just_pressed("Interact") && inPuzzleRoom:
		var tween = create_tween()
		warp_mouse_to_player($bangleBerry)
		tween.tween_property($playerCam, "position", room4pos, 0.5)

	
	
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


func _on_camera_colider_body_entered(body: Node2D) -> void:
	if currentRoom == 1:
		Input.warp_mouse(Vector2(200,-150))
		print("hello")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room2pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 2
	else:		
		Input.warp_mouse(Vector2(0,0))
		print("hi")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room1pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 1



func _on_camera_collider_2_body_entered(body):
	if currentRoom == 1:
		Input.warp_mouse(Vector2(200,-150))
		print("hello")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room3pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 3
	else:		
		Input.warp_mouse(Vector2(0,0))
		print("hi")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room1pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 1


func _on_camera_collider_3_body_entered(body):
	if currentRoom == 3:
		Input.warp_mouse(Vector2(200,-150))
		print("hello")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room4pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 4
	else:		
		Input.warp_mouse(Vector2(0,0))
		print("hi")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($playerCam, "position", room3pos, 0.5)
		warp_mouse_to_player($bangleBerry)
		await get_tree().create_timer(2).timeout
		currentRoom = 3

func _on_prism_puzzle_area_body_entered(body: Node2D) -> void:
	$playerCam/CanvasLayer/Label.text = "Press T to enter/exit Puzzle"
	inPrismArea = true
#Prism Script


@onready var obj1 = $prismPieceOne
@onready var obj2 = $prismPieceTwo
@onready var obj3 = $prismPieceThree
var direction = Vector2.ZERO
var start = 1
func _process(delta):
	if(start == 1):
			obj1.rotate(1.67)
			obj3.rotate(.3)
			start = 2
			Global.selectedPrismPiece=1
	if(Global.selectedPrismPiece == 1):
		rotateFunction(obj1,(4.64*delta),2)
	elif(Global.selectedPrismPiece == 2):
		rotateFunction(obj2,(4.64*delta),3)
	elif(Global.selectedPrismPiece == 3):
		rotateFunction(obj3,(4.64*delta),1)
		#This was how Kenneth originally wanted this if statement 
#if ((-45>(obj3.position.y - obj2.position.y) && (obj3.position.y - obj2.position.y)>-55) && (7>(obj3.position.x - obj2.position.x) && (obj3.position.x - obj2.position.x)>-3) && (-7>(obj2.position.y - obj1.position.y) && (obj2.position.y - obj1.position.y)>-17) && (49>(obj2.position.x - obj1.position.x) && (obj2.position.x - obj1.position.x)>39) && (((5>=obj3.rotation_degrees && obj3.rotation_degrees>=0) || (355>=obj3.rotation_degrees && obj3.rotation_degrees>=360)) && ((5>=obj2.rotation_degrees && obj2.rotation_degrees>=0) || (355>=obj2.rotation_degrees && obj2.rotation_degrees>=360)) && ((5>=obj1.rotation_degrees && obj1.rotation_degrees>=0) || (355>=obj1.rotation_degrees && obj1.rotation_degrees>=360)))):
	if (-45>(obj3.position.y - obj2.position.y) && (obj3.position.y - obj2.position.y)>-55):
		print("works1")
		if (7>(obj3.position.x - obj2.position.x) && (obj3.position.x - obj2.position.x)>-3):
			print("works2")
			if (-7>(obj2.position.y - obj1.position.y) && (obj2.position.y - obj1.position.y)>-17):
				print("works3") 
				if (49>(obj2.position.x - obj1.position.x) && (obj2.position.x - obj1.position.x)>39):
					print("works4") 
					if ((5>=obj3.rotation_degrees && obj3.rotation_degrees>=0) || (355>=obj3.rotation_degrees && obj3.rotation_degrees>=360)):
						print("works5")
						if ((5>=obj2.rotation_degrees && obj2.rotation_degrees>=0) || (355>=obj2.rotation_degrees && obj2.rotation_degrees>=360)):
							print("works6")
							if((5>=obj1.rotation_degrees && obj1.rotation_degrees>=0) || (355>=obj1.rotation_degrees && obj1.rotation_degrees>=360)):
								print("works7")
								var tween = create_tween()
								tween.tween_property($playerCam, "position", room4pos, 0.5)
								warp_mouse_to_player($bangleBerry)


func rotateFunction(object,rotateVelocity, nextInOrder):
	
	if Input.is_action_pressed("Turn Left"):
		object.rotate(rotateVelocity*-1)
	if Input.is_action_pressed("Turn Right"):
		object.rotate(rotateVelocity)
	if Input.is_action_pressed("Up"):
		object.position.y-=.3
	if Input.is_action_pressed("Down"):
		object.position.y+=.3
	if Input.is_action_pressed("Right"):
		object.position.x+=.3
	if Input.is_action_pressed("Left"):
		object.position.x-=.3
	if (object.position.x<0):
		object.position.x=0
	if (object.position.x>320):
		object.position.x=320
	if (object.position.y>0):
		object.position.y=0
	if (object.position.y<-180):
		object.position.y=-180
		
	if Input.is_action_just_pressed("Switch Objects"):
		updateRotation(object,nextInOrder)
func updateRotation(object,nextInOrder):
	while (object.rotation_degrees>360):
		object.rotation_degrees=object.rotation_degrees-360
	while (object.rotation_degrees<0):
		object.rotation_degrees=360+object.rotation_degrees
	print(object.rotation_degrees)
	print(object.position.y)
	Global.selectedPrismPiece = nextInOrder
