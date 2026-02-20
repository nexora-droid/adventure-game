extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
@onready var body: CollisionShape2D = $Body
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_detector: Area2D = $EnemyDetector
@onready var e_detector_hitbox: CollisionShape2D = $EnemyDetector/E_DetectorHitbox
var is_attacking := false
signal damage(id)
var damage_emitted:= false
var can_damage:= true
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if is_attacking and direction != Vector2.ZERO:
		is_attacking = false
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
		if not is_attacking:
			if sprite.animation != "run":
				sprite.play("run")
	else:
		velocity = Vector2.ZERO
		if not is_attacking:
			if sprite.animation != "idle":
				sprite.play("idle")

	if direction.x > 0:
		sprite.flip_h = false
		e_detector_hitbox.position.x = 47
	if direction.x < 0:
		sprite.flip_h = true
		e_detector_hitbox.position.x = -47
	#a
	move_and_slide()
	var obj = enemy_detector.get_overlapping_bodies()
	for enemy in obj:
		if enemy.is_in_group("enemy") and is_attacking and can_damage:
			if damage_emitted == true:
				pass
			else:
				can_damage = false
				emit_signal("damage", enemy.get_instance_id())
				damage_emitted = true
				start_damage_cooldown()
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("action") and is_attacking == false:
		is_attacking = true
		damage_emitted = false
		sprite.stop()
		sprite.play("attack")
		sprite.animation_finished.connect(_on_anim_finish, CONNECT_ONE_SHOT)
func _on_anim_finish() -> void:
	is_attacking = false
func start_damage_cooldown() -> void:
	await get_tree().create_timer(1).timeout
	can_damage = true
