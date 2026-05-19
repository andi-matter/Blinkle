extends Node
class_name LoadSettings

@export var save_button : Button
@export var load_button : Button

@export var settings_file : String = "settings.json"
@export var settings_path : String = "user://"

func _ready() -> void:
	save_button.connect("button_down", save_settings)
	load_button.connect("button_down", load_settings)


var SETTINGS : Dictionary = {
	Constants.SETTINGS.LOCATION_X : 2750,
	Constants.SETTINGS.LOCATION_Y : 0,
	Constants.SETTINGS.TIME_BLINK : 8,
	Constants.SETTINGS.TIME_BETWEEN : 120,
	Constants.SETTINGS.EYE_THEME : Constants.EYETHEME.DEFAULT
}

func save_settings():
	var stringed = {}
	for setting : Constants.SETTINGS in SETTINGS.keys():
		stringed[Constants.SETTINGS.keys()[setting]] = SETTINGS[setting]
	var json = JSON.stringify(stringed)
	var file = FileAccess.open(settings_path.path_join(settings_file), FileAccess.WRITE)
	file.store_string(json)
	file.close()
	pass
	
func load_settings():
	var file = FileAccess.open(settings_path.path_join(settings_file), FileAccess.READ)
	var str = file.get_as_text()
	var json = JSON.parse_string(str) as Dictionary
	print(json)
	for key in json.keys():
		var setting = Constants.SETTINGS.get(key)
		SETTINGS[setting] = json[key]
	print(SETTINGS)
	pass

func change_setting(setting : Constants.SETTINGS, value):
	if setting in SETTINGS.keys():
		SETTINGS[setting] = value

func get_setting(setting : Constants.SETTINGS):
	if setting in SETTINGS.keys():
		return SETTINGS[setting]
	else:
		return null
