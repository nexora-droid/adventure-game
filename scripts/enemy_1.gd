extends CharacterBody2D
 
var is_targeting_player := false
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var player: CharacterBody2D = $"../Player"
var health := 20
var speed := 120
var min_distance := 50
var is_hit := false
var hit_count := 0
var can_damage := true
signal hit_player()
func _ready() -> void:
	player.connect("damage", Callable(self, "_on_damage"))

func _physics_process(delta: float) -> void:
	if not is_hit and sprite.animation != "hit" and sprite.animation != "death":
		var direction = player.position - position
		var distance = direction.length()
		if distance <= 200 and distance > min_distance:
			is_targeting_player = true
			direction = direction.normalized()
			velocity = direction * speed
			move_and_slide()
			if direction.x > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true	
		else:
			is_targeting_player = false
			velocity = Vector2.ZERO
			move_and_slide()
		if is_targeting_player:
			sprite.play("run")
		else:
			sprite.play("idle")
		if distance <= min_distance and can_damage:
			sprite.play("attack")
			await sprite.animation_finished
			emit_signal("hit_player")
		else: 
			can_damage = false
			start_damage_cooldown()
func _on_damage(enemy_id: int) -> void:
	if enemy_id == self.get_instance_id():
		if health <= 10:
			sprite.play("death")
			await sprite.animation_finished
			self.queue_free()
		else:
			health -= 10
			if not is_hit:
				hit_count = 0 
				await  get_tree().create_timer(0.5).timeout
				sprite.play("hit")
				await sprite.animation_finished
				await get_tree().create_timer(0.6).timeout
				sprite.play("hit")
				await sprite.animation_finished
				is_hit = false
				sprite.play("idle")
func start_damage_cooldown() -> void:
	await get_tree().create_timer(1).timeout
	can_damage = true
