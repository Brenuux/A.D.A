extends Node2D
class_name State

func _ready():
	set_physics_process(false)
	
func _enter():
	set_physics_process(true)
	
func exit():
	set_physics_process(false)
	
func _transition():
	pass
	
func _physics_process(_delta):
	transition()
