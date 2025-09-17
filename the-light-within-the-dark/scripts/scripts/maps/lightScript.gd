extends ColorRect

func _ready() -> void:
	#unhide rect
	visible = true

func _process(_delta: float) -> void:
	#define view port and screen size
	var vp = get_viewport()
	var screen_size: Vector2 = Vector2(vp.get_visible_rect().size)

	#gets mouse pos and translates it to UV cords
	var mouse_screen: Vector2 = Vector2(vp.get_mouse_position())
	var mouse_uv: Vector2 = mouse_screen / screen_size

	#sets shader parameters
	material.set_shader_parameter("mousePos", mouse_uv)
	material.set_shader_parameter("aspect", screen_size.x / screen_size.y)
