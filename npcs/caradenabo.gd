extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocidad_mov = 5
var velocidad_max = 25
var GRAVEDAD = 250
var velocidad = Vector2()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	#gravedad
	velocidad.y += GRAVEDAD * delta
	#Maximo de velocidad
	velocidad.x = clamp(velocidad.x, -velocidad_max, velocidad_max)
	#impulso
	if get_node('Sprite').is_flipped_h():
		velocidad.x -= velocidad_mov
	else:
		velocidad.x += velocidad_mov
	#movimiento
	var movimiento = velocidad * delta
	move(movimiento)
	
	#Slide
	if is_colliding():
		var normal = get_collision_normal()
		movimiento = normal.slide(movimiento)
		velocidad = normal.slide(velocidad)
		move(movimiento)
		if normal.x < 0:
			get_node('Sprite').set_flip_h(true)
		elif normal.x > 0:
			get_node('Sprite').set_flip_h(false)