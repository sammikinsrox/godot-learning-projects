extends ParallaxBackground

const SPEED: float = 50.0


func _process(delta: float) -> void:
	scroll_offset.y += SPEED * delta
