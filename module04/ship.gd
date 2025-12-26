extends Sprite2D

@onready var timer: Timer = $Timer

@export var max_speed := 600.0
@export var boost_speed := 1500.0

var normal_speed := max_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0


func _process(delta: float) -> void:
	# calculate direction
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction.length() > 1.0:
		direction = direction.normalized()
		
	# sprite rotation
	if direction.length() > 0.0:
		rotation = velocity.angle()
		
	# boost mechanic
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		timer.start()
	
	# apply velocity
	var desired_velocity := max_speed * direction
	var steering_vector := desired_velocity - velocity
	velocity += steering_factor * steering_vector * delta
	position += velocity * delta


func _on_timer_timeout() -> void:
	max_speed = normal_speed
