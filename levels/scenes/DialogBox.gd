extends NinePatchRect

@onready var text := $Text

var msg_queue: Array = [
	"Oi, tudo bem?",
	"O que faz por aqui?"
]
	
func _imput(event):
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		show_message()

func show_message() -> void:
	if msg_queue.size() == 0:
		hide()
		return
	
	var _msg: String = msg_queue.pop_front()
	
	text.bbcode_text = _msg
	print(msg_queue)
