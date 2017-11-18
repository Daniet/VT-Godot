extends KinematicBody2D

var GRAVEDAD = 200
var Velocidad = Vector2()
export var vel_lateral = 50
export var vel_max = 150

func _ready():
	set_fixed_process(true)
	Velocidad.x = 0
	Velocidad.y = 0

func  _fixed_process(delta):
	Velocidad.y += GRAVEDAD * delta

	if Input.is_action_pressed('ui_right'):
		Velocidad.x += vel_lateral
	elif Input.is_action_pressed('ui_left'):
		Velocidad.x -= vel_lateral
	else:
		Velocidad.x = 0

	Velocidad.x = clamp(Velocidad.x, -vel_max, vel_max)

	var movimiento = Velocidad * delta
	move(movimiento)

	if is_colliding():
		var normal = get_collision_normal()
		movimiento = normal.slide(movimiento)
		Velocidad = normal.slide(Velocidad)
		move(movimiento)
