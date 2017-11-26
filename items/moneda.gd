extends Area2D

func _ready():
	pass


func _on_Monedas_body_enter( body ):
	if body.get_name() == 'Mario':
		self.queue_free()
