extends Area2D

func _ready():
	pass


func _on_Monedas_body_enter( body ):
	# if body.get_name() == 'Mario':
	if body.is_in_group('player'):
		self.queue_free()
