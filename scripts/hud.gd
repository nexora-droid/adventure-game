extends CanvasLayer
@onready var title: Label = $Title
@onready var button: Button = $Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cursor: TextureRect = $Cursor
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var panel_keybind: Panel = $PanelKeybind
@onready var title_keybind: Label = $PanelKeybind/TitleKeybind
@onready var keybinds: Label = $PanelKeybind/Keybinds
var panel_open:= false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("keybind"):
		if panel_open == true:
			animation_player.play_backwards("keybind")
			panel_open = false
		else:
			animation_player.play("keybind")
			panel_open = true
