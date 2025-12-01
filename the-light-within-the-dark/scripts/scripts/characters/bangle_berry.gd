extends CharacterBody2D

#var defineing
var mousePos
@export var speed = 100


func _process(_delta: float) -> void:
	#defining distance
	mousePos = get_global_mouse_position()
	var distanceToMouse = sqrt(((global_position.x - mousePos.x)**2.0) +((global_position.y - mousePos.y)**2.0))
	
	#animation
	if (abs(velocity.x) > 0.5) or (abs(velocity.x) > 0.5):
		if abs(velocity.x)>abs(velocity.y):
			if velocity.x>0:
				$sprite.animation = "walkRight"
			else:
				$sprite.animation = "walkLeft"
		else:
			if velocity.y>0:
				$sprite.animation = "walkDown"
			else:
				$sprite.animation = "walkUp"
	elif abs(velocity.x) < 0.5 and abs(velocity.y) < 0.5:
		$sprite.animation = "idle"
	
	#movement
	if distanceToMouse > 2:
		velocity = (( mousePos - global_position) / distanceToMouse) * speed
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
