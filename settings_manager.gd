extends Node

@export var eye_window : EyeWindow

@export var load_settings : LoadSettings
@export var eye_control : EyeControl

@export var time_blink_slider : HSlider
@export var time_between_slider : HSlider
@export var time_between_box : LineEdit
@export var time_blink_box : LineEdit
@export var window_up_button : Button
@export var window_down_button : Button
@export var window_left_button : Button
@export var window_right_button : Button
@export var eye_theme_menu : OptionButton

var slide_x_rate : int = 5
var slide_y_rate : int = 5
var slide_x : int = 0
var slide_y : int = 0

func _ready() -> void:
	load_settings.load_settings()
	apply_loaded_settings()
	
func _physics_process(delta: float) -> void:
	if slide_x != 0 or slide_y != 0:
		eye_window.position += Vector2i(slide_x * slide_x_rate, slide_y * slide_y_rate)
		load_settings.change_setting(Constants.SETTINGS.LOCATION_X, eye_window.position.x)
		load_settings.change_setting(Constants.SETTINGS.LOCATION_Y, eye_window.position.y)
		

func _on_time_pause_slider_value_changed(value: float) -> void:
	eye_control.stop()
	eye_control.between_time = value
	time_between_box.text = str(value)
	load_settings.change_setting(Constants.SETTINGS.TIME_BETWEEN, value)
	eye_control.resume()
	pass # Replace with function body.


func _on_time_blink_slider_value_changed(value: float) -> void:
	eye_control.stop()
	eye_control.blink_time = value
	time_blink_box.text = str(value)
	load_settings.change_setting(Constants.SETTINGS.TIME_BLINK, value)
	eye_control.resume()
	pass # Replace with function body.


func _on_up_button_button_down() -> void:
	slide_y = -1
	pass # Replace with function body.


func _on_up_button_button_up() -> void:
	slide_y = 0
	pass # Replace with function body.


func _on_right_button_button_down() -> void:
	slide_x = 1
	pass # Replace with function body.


func _on_right_button_button_up() -> void:
	slide_x = 0
	pass # Replace with function body.


func _on_left_button_button_down() -> void:
	slide_x = -1
	pass # Replace with function body.


func _on_left_button_button_up() -> void:
	slide_x = 0
	pass # Replace with function body.


func _on_down_button_button_down() -> void:
	slide_y = 1
	pass # Replace with function body.


func _on_down_button_button_up() -> void:
	slide_y = 0
	pass # Replace with function body.


func _on_eye_theme_menu_item_selected(index: int) -> void:
	## apply theme settings, when they exist...
	load_settings.change_setting(Constants.SETTINGS.EYE_THEME, index)
	pass # Replace with function body.


func _on_save_button_button_down() -> void:
	load_settings.save_settings()
	pass # Replace with function body.


func _on_load_button_button_down() -> void:
	load_settings.load_settings()
	apply_loaded_settings()
	pass # Replace with function body.

func apply_loaded_settings():
	time_blink_slider.value = load_settings.get_setting(Constants.SETTINGS.TIME_BLINK)
	time_between_slider.value = load_settings.get_setting(Constants.SETTINGS.TIME_BETWEEN)
	#eye_theme_menu.select(load_settings.get_setting(Constants.SETTINGS.EYE_THEME))
	eye_window.position = Vector2i(load_settings.get_setting(
		Constants.SETTINGS.LOCATION_X),
		load_settings.get_setting(Constants.SETTINGS.LOCATION_Y)
		)
	pass
	


func _on_reset_location_button_down() -> void:
	eye_window.position = Vector2i.ZERO
	load_settings.change_setting(Constants.SETTINGS.LOCATION_Y, eye_window.position.y)
	load_settings.change_setting(Constants.SETTINGS.LOCATION_X, eye_window.position.x)
	pass # Replace with function body.


func _on_quit_button_button_down() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
	pass # Replace with function body.


func _on_pause_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		var as_float : float = new_text.to_float()
		as_float = max(1, as_float)
		time_between_slider.value = as_float
	pass # Replace with function body.


func _on_blink_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		var as_float : float = new_text.to_float()
		as_float = max(1, as_float)
		time_blink_slider.value = as_float
	pass # Replace with function body.
