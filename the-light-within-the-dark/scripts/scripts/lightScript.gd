extends ColorRect

func _process(_delta: float) -> void:
	var screenSize = Vector2(get_viewport().size)
	var mouse_uv = get_viewport().get_mouse_position() / screenSize
	material.set_shader_parameter("mousePos", mouse_uv)
	material.set_shader_parameter("aspect", size.x / size.y)
