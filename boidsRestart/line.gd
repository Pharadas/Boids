extends Line2D

func _ready():
	add_point(Vector2(0, 0))
	add_point(Vector2(0, 0))

#func _process(delta):
#	set_point_position(0, Vector2(0, 0))
#	set_point_position(1, Vector2(0, 0))

func cleanAllLines():
	set_point_position(0, Vector2(0, 0))
	set_point_position(1, Vector2(0, 0))

func centerOfBoids(centerOfMainBoid, centerFound):
	set_point_position(0, Vector2(0, 0))
	set_point_position(1, centerOfMainBoid - centerFound)

func drawFoundBoid(ownerBoidPosition, foundBoidPosition):
	set_point_position(0, Vector2(0, 0))
	set_point_position(1,  foundBoidPosition - ownerBoidPosition)
