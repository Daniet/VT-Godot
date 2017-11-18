extends KinematicBody2D

var GRAVEDAD = 200
var Velocidad = Vector2()
var vel_lateral = 50

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

	var movimiento = Velocidad * delta
	move(movimiento)
