extends Node2D

@onready var obj1 = $prismPieceOne
@onready var obj2 = $prismPieceTwo
@onready var obj3 = $prismPieceThree
var rotationSpeed = .1
var direction = Vector2.ZERO
var start = 1
func _process(delta):
	print("damn it")
#	if(start == 1):
#			obj1.rotate(1.67)
#			obj3.rotate(.3)
#			start = 2
#			Global.selectedPrismPiece=1
	if(Global.selectedPrismPiece == 1):
		rotateFunction(obj1,0.1,2)
	elif(Global.selectedPrismPiece == 2):
		rotateFunction(obj2,0.1,3)
	elif(Global.selectedPrismPiece == 3):
		rotateFunction(obj3,0.1,1)
#	if ((obj1.rotation_degrees>340 || obj1.rotation_degrees<20) && (obj1.rotation_degrees>340 || obj2.rotation_degrees<20) && (obj1.rotation_degrees>340 || obj1.rotation_degrees<20)):
#		Global.selectedPrismPiece
		
func rotateFunction(object,rotateVelocity, nextInOrder):
	
	if Input.is_action_pressed("Turn Left"):
		object.rotate(rotateVelocity*-1)
	if Input.is_action_pressed("Turn Right"):
		object.rotate(rotateVelocity)
	if Input.is_action_pressed("Up"):
		object.direction.y-=1
	if Input.is_action_pressed("Down"):
		object.direction.y+=1
	if Input.is_action_pressed("Right"):
		object.direction.x+=1
	if Input.is_action_pressed("Left"):
		object.direction.x-=1
	if Input.is_action_just_pressed("Switch Objects"):
		print(object)
		updateRotation(object,nextInOrder)
func updateRotation(object,nextInOrder):
	while (object.rotation_degrees>360):
		object.rotation_degrees=object.rotation_degrees-360
	while (object.rotation_degrees<0):
		object.rotation_degrees=360+object.rotation_degrees
	print(object.rotation_degrees)
	if(object.rotation_degrees>0&&object.rotation_degrees<360):
		Global.selectedPrismPiece = nextInOrder
