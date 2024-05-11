extends Button

@onready var setting = %Settings

func _on_pressed():
	setting.show()
	get_parent().hide()
