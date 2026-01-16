extends CharacterBody2D

@export var speed: float = 260.0

# Disparo
@export var projectile_scene: PackedScene
@export var fire_rate: float = 0.25  
var _cooldown: float = 0.0

func _physics_process(delta: float) -> void:
	# Movimiento
	var dir := Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	velocity = dir * speed
	move_and_slide()

	# Mirar al mouse
	look_at(get_global_mouse_position())

	# Cooldown
	_cooldown = maxf(_cooldown - delta, 0.0)

	# Disparo
	if Input.is_action_pressed("disparo") and _cooldown <= 0.0:
		shoot()
		_cooldown = fire_rate

func shoot() -> void:
	if projectile_scene == null:
		return

	var p = projectile_scene.instantiate()

	var forward := Vector2.RIGHT.rotated(rotation)
	var spawn_offset := 18.0  # ajusta 14–24 según tu tamaño

	p.global_position = global_position + forward * spawn_offset
	p.rotation = rotation

	get_tree().current_scene.add_child(p)
