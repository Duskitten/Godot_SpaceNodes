class_name PhysicsSpace2D
extends Node2D

var NewSpace:RID

func _ready() -> void:
	NewSpace = PhysicsServer2D.space_create()
	_propagate_enter_space(self)

func _propagate_enter_space(NodeVal:Node) -> void:
	print(NodeVal)
	if (NodeVal is StaticBody2D || 
	   NodeVal is RigidBody2D || 
	   NodeVal is CharacterBody2D):
		PhysicsServer2D.body_set_space(NodeVal.get_rid(), NewSpace)
		print("Oi!")
		PhysicsServer2D.space_set_active(NewSpace,true)
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
	elif (NodeVal is Area2D):
		PhysicsServer2D.area_set_space(NodeVal.get_rid(), NewSpace)
		PhysicsServer2D.space_set_active(NewSpace,true)
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
	elif (NodeVal is PhysicsSpace2D && NodeVal != self):
		pass
	else:
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
