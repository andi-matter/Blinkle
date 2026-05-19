extends Control


func _physics_process(delta: float) -> void:
	if dragging:
		get_window().position = Vector2i(Vector2(get_window().position).lerp(Vector2i(get_global_mouse_position()) + mouse_offset, 0.8))

var dragging : bool = false
var mouse_offset : Vector2i
func _on_drag_area_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var was_dragging = dragging
			if event.is_pressed():
				dragging = true
				if !was_dragging:
					mouse_offset = get_window().position - Vector2i(get_global_mouse_position())
			else:
				dragging = false
	pass # Replace with function body.


func _on_drag_area_mouse_exited() -> void:
	#dragging = false
	pass # Replace with function body.
