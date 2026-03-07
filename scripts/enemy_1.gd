extends CharacterBody2D
# This script was fixed by AI, orignal drafts were written by me(glitch_purge/github: nexora-droid) but enemy animation was fixed by AI, so was code improved and refactored (if that means change for improvement)
var is_targeting_player := false
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var player: CharacterBody2D = $"../Player"
var health := 100
var speed := 120
var min_distance := 50
var is_hit := false
var can_damage := true
var is_attacking := false
signal hit_player()
func _ready() -> void:
	player.connect("damage", Callable(self, "_on_damage"))
func _physics_process(delta: float) -> void:
	if is_hit or sprite.animation=="death":
		move_and_slide()
		return
	var direction=player.position-position
	var distance=direction.length()
	if distance<=min_distance:
		velocity=Vector2.ZERO
		move_and_slide()
		if can_damage and not is_attacking:
			damage()
		elif not is_attacking:
			sprite.play("idle")
	elif distance<=300:
		if is_attacking:
			move_and_slide()
			return
		sprite.play("run")
		direction=direction.normalized()
		velocity=direction*speed
		move_and_slide()
		sprite.flip_h=direction.x<0
	else:
		velocity=Vector2.ZERO
		move_and_slide()
		if not is_attacking:
			sprite.play("idle")
func damage() -> void:
	if not can_damage or is_attacking:
		return
	is_attacking = true
	can_damage = false
	velocity = Vector2.ZERO
	sprite.play("attack")
	await sprite.animation_finished
	if (player.position - position).length() <= min_distance:
		emit_signal("hit_player")
	sprite.play("idle")
	await get_tree().create_timer(0.5).timeout
	can_damage = true
	is_attacking = false
	
func _on_damage(enemy_id: int) -> void:
	if enemy_id != get_instance_id():
		return
	if health == 20:
		sprite.play("death")
		await sprite.animation_finished
		queue_free()
	else:
		health -= 20
		if not is_hit:
			is_hit = true
			sprite.play("hit")
			await sprite.animation_finished
			is_hit = false
			sprite.play("idle")
