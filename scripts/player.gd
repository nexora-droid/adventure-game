extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var attack_detector: CollisionShape2D = $Attack_Detector
@onready var body: CollisionShape2D = $Body
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run")
	if direction.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run")
	if direction == Vector2.ZERO:
		animated_sprite_2d.play("idle")
	move_and_slide()
