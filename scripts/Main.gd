extends Node2D

const BLOCK_COLOR := Color("#8b5a2b")
const GROUND_Y := 470
const WORLD_WIDTH := 2200

var player_scene := preload("res://scenes/Player.tscn")
var enemy_scene := preload("res://scenes/Enemy.tscn")
var player: CharacterBody2D

func _ready() -> void:
    build_level()
    spawn_player()
    spawn_enemies()
    print("Mario Maker 3 Prototype ready")

func build_level() -> void:
    # Ground row
    for x in range(0, WORLD_WIDTH, 32):
        create_block(Vector2(x + 16, GROUND_Y + 16), Vector2(32, 32), Color("#7a4a38"))

    # Floating platforms
    for platform in [
        Vector2(240, 390),
        Vector2(420, 340),
        Vector2(690, 300),
        Vector2(930, 360),
        Vector2(1200, 325),
        Vector2(1520, 280),
        Vector2(1780, 330),
        Vector2(1960, 390)
    ]:
        create_block(platform, Vector2(120, 26), Color("#d2a371"))

    # Decorative blocks
    for block in [
        Vector2(110, 430),
        Vector2(170, 430),
        Vector2(730, 430),
        Vector2(760, 430),
        Vector2(1340, 430),
        Vector2(1470, 430),
        Vector2(1800, 430)
    ]:
        create_block(block, Vector2(32, 32), Color("#d6b36c"))

    # Question-block style collectibles
    for coin_pos in [
        Vector2(130, 390),
        Vector2(330, 300),
        Vector2(620, 250),
        Vector2(840, 300),
        Vector2(1180, 260),
        Vector2(1490, 230),
        Vector2(1710, 270),
        Vector2(1940, 320)
    ]:
        create_coin(coin_pos)

func create_block(position: Vector2, size: Vector2, color: Color) -> void:
    var body := StaticBody2D.new()
    var collision := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    var rect := ColorRect.new()

    shape.size = size
    collision.shape = shape
    collision.position = Vector2.ZERO
    body.add_child(collision)

    rect.position = Vector2(-size.x / 2.0, -size.y / 2.0)
    rect.size = size
    rect.color = color
    body.add_child(rect)

    body.position = position
    add_child(body)

func create_coin(position: Vector2) -> void:
    var area := Area2D.new()
    var collision := CollisionShape2D.new()
    var circle := CircleShape2D.new()
    var rect := ColorRect.new()

    circle.radius = 8
    collision.shape = circle
    area.add_child(collision)

    rect.position = Vector2(-8, -8)
    rect.size = Vector2(16, 16)
    rect.color = Color("#ffd76a")
    area.add_child(rect)

    area.position = position
    area.body_entered.connect(_on_coin_collected.bind(area))
    add_child(area)

func _on_coin_collected(body: Node, coin: Area2D) -> void:
    if body.name != "Player":
        return

    if coin and is_instance_valid(coin):
        coin.queue_free()

    if player and player.has_method("collect_coin"):
        player.collect_coin()

func spawn_player() -> void:
    player = player_scene.instantiate()
    player.position = Vector2(100, 320)
    player.died.connect(_on_player_died)
    add_child(player)

func _on_player_died() -> void:
    if is_instance_valid(player):
        player.queue_free()

    call_deferred("spawn_player")

func spawn_enemies() -> void:
    for enemy_position in [
        Vector2(480, 440),
        Vector2(800, 440),
        Vector2(1240, 440),
        Vector2(1680, 440)
    ]:
        var enemy = enemy_scene.instantiate()
        enemy.position = enemy_position
        add_child(enemy)
