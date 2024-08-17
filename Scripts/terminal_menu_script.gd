extends Node2D


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		self.visible = false

func _ready() -> void:
	#self.visible = false
	pass


func _process(delta: float) -> void:
	pass

#
#func _on_hidden() -> void:
	#pass # Replace with function body.
