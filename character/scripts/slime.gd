extends CharacterBody2D
class_name Slime

var _player_ref = null

@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null


#codigo verificando quem entrou na area de colisão é do grupo "character" para para seguir
func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body
	


# caso o personagem do grupo "character" sair da colisão, slime não vai seguir
func _on_detection_area_body_exited(_body):
	if _body.is_in_group("character"):
		_player_ref = null
	
func _physics_process(_delta: float) -> void:
	_animate()
	if _player_ref != null:
		if _player_ref.is_dead:
			velocity = Vector2.ZERO
			move_and_slide()
			return
			
			
		#vai retornar a direção do slime e personagem
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distance: float = global_position.distance_to(_player_ref.global_position)
			
		if _distance < 20:
			_player_ref.die()

			
		velocity = _direction * 30
		move_and_slide()

func _animate() -> void:
	if velocity.x > 0:
		_texture.flip_h = false
	
	if velocity.x < 0:
		_texture.flip_h = true
	
	if velocity != Vector2.ZERO:
		_animation.play("walk")
		return
		
	_animation.play("idle")
