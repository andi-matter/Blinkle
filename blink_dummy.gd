extends TextureRect
class_name BlinkDummy

var animated : bool = false

func blink():
	if animated:
		var tween = get_tree().create_tween()
		tween.set_parallel(false)
		tween.tween_property(self, "offset_transform_scale:y", 0.3, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "offset_transform_scale:y", 1.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		await tween.finished
		blink()
