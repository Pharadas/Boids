tool
extends RigidBody

export var angleLimits = [225, 310]
export var rayCastDistance = 50
export var maxForce = 1000
var initForceX = rand_range(0, maxForce)
var initForceY = sqrt(pow(maxForce, 2) - pow(initForceX, 2))
var initForceZ = sqrt(pow(maxForce, 2) - pow(initForceY, 2))
var resultantBoidPush = Vector2(0, 0)
var currCenter = Vector2(0, 0)
var currAveHeading = Vector2(0, 0)
var boidsFound = 0

func _ready():
	randomize()
	
	var negatiffierX = rand_range(0, 1)
	var negatiffierY = rand_range(0, 1)
	var negatiffierZ = rand_range(0, 1)
	
	if negatiffierX > 0.5:
		negatiffierX = 1
	else:
		negatiffierX = -1

	if negatiffierY > 0.5:
		negatiffierY = 1
	else:
		negatiffierY = -1
		
	if negatiffierZ > 0.5:
		negatiffierZ = 1
	else:
		negatiffierZ = -1
		
	apply_impulse(Vector3(0, 0, 0), Vector3(initForceX * negatiffierX, initForceY * negatiffierY, initForceZ * negatiffierZ))

#func _integrate_forces(state):
#	var linear_velocity = get_linear_velocity()
#	if boidsFound > 0:
#		var totalForce = ((resultantBoidPush) + (currAveHeading) + (currCenter / boidsFound)).normalized() * maxForce * 2
#		set_applied_force(totalForce)
#	set_rotation(linear_velocity.angle())
#	set_linear_velocity(linear_velocity.normalized() * maxForce)
#
#	resultantBoidPush = Vector2(0, 0)
#	currCenter = Vector2(0, 0)
#	boidsFound = 0
#	currAveHeading = Vector2(0, 0)
	
func _process(delta):
	global_rotate(Vector3(0, 0, 0), 0.01745)
	if global_transform.origin.x > 1000:
		global_transform.origin.x = 0
	elif global_transform.origin.x < 0:
		global_transform.origin.x = 1000
	
	if global_transform.origin.y > 1000:
		global_transform.origin.y = 0
	elif global_transform.origin.y < 0:
		global_transform.origin.y = 1000
	
	if global_transform.origin.z > 1000:
		global_transform.origin.z = 0
	elif global_transform.origin.z < 0:
		global_transform.origin.z = 1000
	
#func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
#	var foundBoidPosition = area.get_parent().get_global_position()
#	var this = pow((get_global_position() - foundBoidPosition).length(), 3)
#
#	if this > 0:
#		resultantBoidPush =  1 / this
#	resultantBoidPush = resultantBoidPush * (get_global_position() - foundBoidPosition)
#
#	boidsFound += 1
#	currCenter += foundBoidPosition
#	currAveHeading += area.get_parent().get_linear_velocity().normalized()
