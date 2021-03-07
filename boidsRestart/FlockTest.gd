extends Node2D

var screenSize = Vector2(0, 0)
var mutex
var thread1
var thread2
var thread3
var thread4

func _ready():
	randomize()
	mutex = Mutex.new()
	var screenSize = get_viewport().get_visible_rect().size

func _process(delta):
	if Input.is_action_pressed('action'):
#		thread1 = Thread.new()
#		thread1.start(self, "addBoidInThread")
#
#		thread2 = Thread.new()
#		thread2.start(self, "addBoidInThread")
#
#		thread3 = Thread.new()
#		thread3.start(self, "addBoidInThread")
#
#		thread4 = Thread.new()
#		thread4.start(self, "addBoidInThread")

		addBoidInMain()
			
	if Input.is_action_just_pressed('shift'):
		queue_free()
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		print ("You are quit!")
		queue_free() # default behavior

func addBoidInMain():
	var boid = preload("res://SingleBoid.tscn")
	for i in range(15):
		var boidInstance = boid.instance()
		var newBoid = add_child(boidInstance)
	
		boidInstance.position = Vector2(rand_range(0, 1025), rand_range(0, 600))

func addBoidInThread(userdata):
	var boid = preload("res://SingleBoid.tscn")
	for i in range(5):
		var boidInstance = boid.instance()
		boidInstance.position = Vector2(rand_range(0, 1025), rand_range(0, 600))
		call_deferred("add_child", boidInstance)

#func _exit_tree():
#	thread1.wait_to_finish()
#	thread2.wait_to_finish()
#	thread3.wait_to_finish()
#	thread4.wait_to_finish()
