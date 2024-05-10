extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#função ao clicar iniciar irá jogar na cena teste
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/scenes/test_level_2.tscn")


#ao clicar em sair vai fechar o game 
func _on_quit_button_pressed():
	get_tree() .quit()
