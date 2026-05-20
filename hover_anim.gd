extends Node
class_name HoverAnim

@export var hover_animated : bool = true
@export var click_animated : bool = true
@export var click_button_index : int = MOUSE_BUTTON_LEFT

@export var detect_control : Control
@export var animated_control : Control

var tween : Tween
var click_tween: Tween

var rotate_multiplier : float = 1.0
var scale_multiplier : float = 1.0

func _ready():
	detect_control.connect("mouse_entered", _on_mouse_entered_detect)
	detect_control.connect("mouse_exited", _on_mouse_exited_detect)
	detect_control.connect("gui_input", _on_gui_input_detect)
	
	rotate_multiplier = 1.2 - (animated_control.size.x / 445.0)
	scale_multiplier = 1.2 - (animated_control.size.x / 445.0)
	print(scale_multiplier)

func _on_mouse_entered_detect():
	if !hover_animated:
		return
	print("hover anim")
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	var rot = deg_to_rad([-1.0, 1.0].pick_random() * randf_range(5, 15) * rotate_multiplier)
	tween.set_parallel(true)
	tween.tween_property(animated_control, "offset_transform_rotation", rot, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(animated_control, "offset_transform_scale:y", 0.75, 0.13).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var scale = max(1.2 * scale_multiplier, 1.05)
	tween.tween_property(animated_control, "offset_transform_scale:x", scale, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.chain().tween_property(animated_control, "offset_transform_rotation", 0.0, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(animated_control, "offset_transform_scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	pass
	
func _on_gui_input_detect(event : InputEvent):
	if !click_animated:
		return
	if event is InputEventMouseButton:
		if event.button_index == click_button_index:
			if event.is_pressed():
				if click_tween:
					click_tween.kill()
				click_tween = get_tree().create_tween()
				click_tween.set_parallel(true)
				var scale = max(1.2 * scale_multiplier, 1.05)
				click_tween.tween_property(animated_control, "offset_transform_scale:y", scale, 0.13).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
				click_tween.tween_property(animated_control, "offset_transform_scale:x", scale, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
				
				click_tween.chain().tween_property(animated_control, "offset_transform_scale", Vector2.ONE, 0.1)
				pass
	
func _on_mouse_exited_detect():
	pass
