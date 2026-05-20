extends TextureRect

@export var max_x_offset : float = 40
@export var max_y_offset : float = 5

var max_radius : float

@export var reference_point : Control
var reference_pos : Vector2
@export var is_tracking : bool = true

func _ready() -> void:
	max_radius = sqrt(max_x_offset*max_x_offset + max_y_offset*max_y_offset)
	reference_pos = global_position + size/2

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var offset = mouse_pos - reference_pos
	var rad_fac = 1.0 - 1.0 / (1.0 + exp(offset.length() / 700.0))
	var track_pos = offset.normalized() * min(offset.length(), max_radius * rad_fac)
	offset_transform_position = offset_transform_position.slerp(track_pos, 0.06)
	pass
