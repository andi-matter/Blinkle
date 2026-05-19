extends Node
class_name EyeControl

@export var eye_window : EyeWindow
@export var blink_timer : Timer
@export var between_timer : Timer

var blink_time : float = 8.0 : #seconds
	get:
		return blink_time
	set(value):
		blink_time = value
		blink_timer.wait_time = blink_time

var between_time : float = 120.0 : #seconds
	get:
		return between_time
	set(value):
		between_time = value
		between_timer.wait_time = between_time

var display_ind : int = 0

func _ready() -> void:
	blink_timer.connect("timeout", _on_blink_timer_timeout)
	between_timer.connect("timeout", _on_between_timer_timeout)
	
	stop()
	blink_timer.wait_time = blink_time
	between_timer.wait_time = between_time
	
	resume()
	
func stop():
	blink_timer.stop()
	between_timer.stop()
	hide_eye_window()

func resume():
	between_timer.start()

func hide_eye_window():
	eye_window.hide_content()

func show_eye_window():
	eye_window.show_content()
	
func _on_blink_timer_timeout():
	print("between blinks")
	hide_eye_window()
	between_timer.start()
	pass
	
func _on_between_timer_timeout():
	print("should blink")
	show_eye_window()
	blink_timer.start()
	pass
