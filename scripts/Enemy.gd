extends CharacterBody2D

const SPEED := 60.0
const GRAVITY := 900.0

var direction := -1.0
var alive := true

func _physics_process(delta: float) -> void:
    if not alive:
        return

    if not is_on_floor():
        velocity.y += GRAVITY * delta
    else:
        velocity.y = 0.0

    velocity.x = direction * SPEED

    if is_on_wall() or not is_on_floor():
        direction *= -1.0

    move_and_slide()

func stomped() -> void:
    if alive:
        alive = false
        queue_free()
