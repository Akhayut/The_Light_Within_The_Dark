extends CharacterBody2D

var mousePos
@export var speed = 6700


func _process(delta: float) -> void:
	#defineing distance
	mousePos = get_global_mouse_position()
	var distanceToMouse = sqrt(((global_position.x - mousePos.x)**2.0) +((global_position.y - mousePos.y)**2.0))
	
	#flipping sprite
	if  mousePos.x - global_position.x > 2:
		$sprite.flip_h = true
	elif  mousePos.x - global_position.x < 2:
		$sprite.flip_h = false
	
	#movement
	if distanceToMouse > 2:
		velocity = (( mousePos - global_position) / distanceToMouse) * (speed * delta)
		$sprite.animation = "walk"
	else:
		velocity = Vector2(0,0)
		$sprite.animation = "idle"
	move_and_slide()
