extends StaticBody3D

@onready var terminal_menu : Node2D = $TerminalMenu

signal menu_hidden()

func interact():
	terminal_menu.visible = true
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_terminal_menu_hidden() -> void:
	emit_signal("menu_hidden")
