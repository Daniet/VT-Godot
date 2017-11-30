extends KinematicBody2D

var GRAVEDAD = 200
var Velocidad = Vector2()
export var vel_lateral = 50
export var vel_max = 150
var vel_salto = 300

var anim_play
var salto = false

var hongoR = preload('res://items/HongoR.tscn')

func _ready():
	set_fixed_process(true)
	Velocidad.x = 0
	Velocidad.y = 0
	anim_play = get_node('AnimationPlayer')

func  _fixed_process(delta):
	Velocidad.y += GRAVEDAD * delta

	if Input.is_action_pressed('ui_right'):
		Velocidad.x += vel_lateral
		if !anim_play.is_playing():
			anim_play.play('mover')
		get_node('spr_Mario').set_flip_h(false)
	elif Input.is_action_pressed('ui_left'):
		Velocidad.x -= vel_lateral
		if !anim_play.is_playing():
			anim_play.play('mover')
		get_node('spr_Mario').set_flip_h(true)
	else:
		Velocidad.x = 0

	if Input.is_action_pressed('ui_up') && !salto:
		Velocidad.y -= vel_salto
		salto = true

	Velocidad.x = clamp(Velocidad.x, -vel_max, vel_max)

	var movimiento = Velocidad * delta
	move(movimiento)

	if is_colliding():
		procesar_colision()
		var normal = get_collision_normal()
		movimiento = normal.slide(movimiento)
		Velocidad = normal.slide(Velocidad)
		move(movimiento)
		if normal.y < 0:
			salto = false

func procesar_colision():
	var obj_colision = get_collider()
	if obj_colision.is_in_group('cuboS'):
		var hongoNuevo = hongoR.instance()
		get_parent().add_child(hongoNuevo)
		hongoNuevo.set_global_pos(Vector2(obj_colision.get_global_pos().x, obj_colision.get_global_pos().y - 30))
