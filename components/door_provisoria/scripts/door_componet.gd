extends Area2D
class_name DoorComponet

func _on_body_entered(_body) -> void:
	if _body is Character:
			print("A")

