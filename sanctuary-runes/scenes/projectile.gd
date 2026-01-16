extends Area2D

@export var speed: float = 700.0
@export var lifetime: float = 1.2

var _t: float = 0.0

func _ready() -> void:
	# Detecta cuando toca un cuerpo
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Avanza hacia adelante usando su rotación
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

	_t += delta
	if _t >= lifetime:
		queue_free()


func _on_body_entered(_body: Node) -> void:
	queue_free()
