extends CollisionPolygon2D

func _process(delta):
#	if Engine.editor_hint:
	set_rotation(deg2rad(get_parent().get_rotation()))
