extends CharacterBody2D
class_name Player

var _state_machine
var is_dead: bool = false
var _is_attacking: bool = false

@export_category("Variables")
@export var _move_speed: float = 64.0
@export var _friction: float = 0.2
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _attack_timer: Timer = null
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_animation_tree.active = true
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(_delta: float) -> void:
	if is_dead:
		return
		
	_move()
	_attack()
	_animate()
	move_and_slide()

func _move() -> void:
	var _direction : Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		_animation_tree["parameters/attack/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)

func _attack() -> void:
	if Input.is_action_just_pressed("attack") and _is_attacking == false:
		set_physics_process(false)
		_attack_timer.start()
		_is_attacking = true
	
func _animate() -> void:
	if _is_attacking:
		_state_machine.travel("attack")
		$"swing-espada".play()
		return
		
	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")

func _on_attack_timer_timeout() -> void:
	set_physics_process(true)
	_is_attacking = false

func _on_attack_area_body_entered(_body) -> void:
	if _body.is_in_group("enemy"):
		_body.apply_damage(20)  # Chamando a função apply_damage com o dano desejado

func die() -> void:
	is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
