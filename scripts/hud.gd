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
@onready var player: CharacterBody2D = $"../Player"
@onready var heart_0: TextureRect = $Heart0
@onready var heart_1: TextureRect = $Heart1
@onready var heart_2: TextureRect = $Heart2
@onready var heart_3: TextureRect = $Heart3
@onready var heart_4: TextureRect = $Heart4

func _ready() -> void:
	player.connect("update_bar", Callable(self, "_update_bar"))


func _update_bar(health) -> void:
	if health == 100:
		heart_4.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
		heart_3.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
		heart_2.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
		heart_1.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
		heart_0.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
	if health == 80:
		heart_4.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_empty.png")
	if health == 90:
		heart_4.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
	if health == 70:
		heart_3.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
	if health == 60:
		heart_3.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_empty.png")
	if health == 50:
		heart_2.texture =  load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
	if health == 40:
		heart_2.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_empty.png")
	if health == 30:
		heart_1.texture =  load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
	if health == 20:
		heart_1.texture = load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_empty.png")
	if health == 10:
		heart_0.texture =  load("res://assets/sprites/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
	if health == 0:
		print("oof")
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("keybind"):
		if panel_open == true:
			animation_player.play_backwards("keybind")
			panel_open = false
		else:
			animation_player.play("keybind")
			panel_open = true
