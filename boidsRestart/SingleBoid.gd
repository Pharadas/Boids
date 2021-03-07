extends RigidBody2D

export var angleLimits = [225, 310]
export var rayCastDistance = 50
export var maxForce = 100
var initForceX = rand_range(0, maxForce)
var initForceY = sqrt(pow(maxForce, 2) - pow(initForceX, 2))
var resultantBoidPush = Vector2(0, 0)
var currCenter = Vector2(0, 0)
var currAveHeading = Vector2(0, 0)
var boidsFound = 0

func _ready():
	randomize()
	
	var negatiffierX = rand_range(0, 1)
	var negatiffierY = rand_range(0, 1)
	
	if negatiffierX > 0.5:
		negatiffierX = 1
	else:
		negatiffierX = -1

	if negatiffierY > 0.5:
		negatiffierY = 1
	else:
		negatiffierY = -1
		
	apply_impulse(Vector2(0, 0), Vector2(initForceX * negatiffierX, initForceY * negatiffierY))

func _integrate_forces(state):
	var linear_velocity = get_linear_velocity()
	if boidsFound > 0:
		var totalForce = ((resultantBoidPush * 200) + (currAveHeading) + (currCenter / boidsFound)).normalized() * maxForce * 2
		set_applied_force(totalForce)
	set_rotation(linear_velocity.angle())
	set_linear_velocity(linear_velocity.normalized() * maxForce)
	
	resultantBoidPush = Vector2(0, 0)
	currCenter = Vector2(0, 0)
	boidsFound = 0
	currAveHeading = Vector2(0, 0)
	
func _process(delta):
	if position.x > 1025:
		position.x = 0
	elif position.x < 0:
		position.x = 1025
	
	if position.y > 600:
		position.y = 0
	elif position.y < 0:
		position.y = 600
	
func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	var foundBoidPosition = area.get_parent().get_global_position()
	var this = pow((get_global_position() - foundBoidPosition).length(), 3)
	
	if this > 0:
		resultantBoidPush =  1 / this
	resultantBoidPush = resultantBoidPush * (get_global_position() - foundBoidPosition)
	
	boidsFound += 1
	currCenter += foundBoidPosition
	currAveHeading += area.get_parent().get_linear_velocity().normalized()
