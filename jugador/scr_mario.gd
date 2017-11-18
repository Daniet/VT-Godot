extends KinematicBody2D

var GRAVEDAD = 200
var Velocidad = Vector2()

func _ready():
	set_fixed_process(true)
	Velocidad.x = 0
	Velocidad.y = 0

func  _fixed_process(delta):
	Velocidad.y += GRAVEDAD * delta
	var movimiento = Velocidad * delta
	move(movimiento)
