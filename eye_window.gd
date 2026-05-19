extends Window
class_name EyeWindow

@export var content_control : Control
@export var blink_dummy : BlinkDummy

@export var x_coord : int = 2800
@export var y_coord : int = 0

var showhide_tween : Tween

func _ready() -> void:
	position = Vector2(x_coord, y_coord)
	content_control.modulate.a = 0.0

func show_content():
	#show()
	if showhide_tween:
		showhide_tween.kill()
	showhide_tween = get_tree().create_tween()
	showhide_tween.tween_property(content_control, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	blink_dummy.animated = true
	blink_dummy.blink()
	pass

func hide_content():
	if showhide_tween:
		showhide_tween.kill()
	showhide_tween = get_tree().create_tween()
	showhide_tween.tween_property(content_control, "modulate:a", 0.0, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	blink_dummy.animated = false
	await showhide_tween.finished
	#hide()
	pass
