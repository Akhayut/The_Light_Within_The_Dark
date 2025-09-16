extends CharacterBody2D

var mousePos
var moving = false
@export var speed = 6700


func _process(delta: float) -> void:
	#defineing distance
	mousePos = get_global_mouse_position()
	var distanceToMouse = sqrt(((global_position.x - mousePos.x)**2.0) +((global_position.y - mousePos.y)**2.0))
	
	#flipping sprite/animation
	if  mousePos.x - global_position.x > 2:
		$sprite.flip_h = true
	elif  mousePos.x - global_position.x < 2:
		$sprite.flip_h = false
		
	if abs(velocity.x) < 0.001 or abs(velocity.y) < 0.001:
		moving = false
	else:
		moving = true
		
	print(velocity)
		
	if moving == false:
		$sprite.animation = "idle"
	else:
		$sprite.animation = "walk"
	
	
	
	#movement
	if distanceToMouse > 2:
		velocity = (( mousePos - global_position) / distanceToMouse) * (speed * delta)
	else:
		velocity = Vector2(0,0)
	move_and_slide()
