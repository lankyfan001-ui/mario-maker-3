extends CharacterBody2D

signal died

const SPEED := 180.0
const JUMP_VELOCITY := -360.0
const GRAVITY := 920.0
const MAX_FALL_SPEED := 700.0

var facing := 1
var coins := 0

func _physics_process(delta: float) -> void:
    var move_direction := Input.get_axis("move_left", "move_right")

    if move_direction:
        velocity.x = move_direction * SPEED
        facing = int(sign(move_direction))
    else:
        velocity.x = move_toward(velocity.x, 0.0, SPEED * 10.0 * delta)

    if not is_on_floor():
        velocity.y += GRAVITY * delta
    else:
        if Input.is_action_just_pressed("jump"):
            velocity.y = JUMP_VELOCITY

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    if velocity.y > MAX_FALL_SPEED:
        velocity.y = MAX_FALL_SPEED

    move_and_slide()

    for index in get_slide_collision_count():
        var collision = get_slide_collision(index)
        var collider = collision.get_collider()

        if collider and collider.has_method("stomped"):
            if collision.get_normal().y < -0.45 and velocity.y > 0.0:
                velocity.y = -220.0
                collider.stomped()
            else:
                die()

    if global_position.y > 900:
        die()

func die() -> void:
    emit_signal("died")
    queue_free()

func collect_coin() -> void:
    coins += 1
    print("Coins: %d" % coins)
