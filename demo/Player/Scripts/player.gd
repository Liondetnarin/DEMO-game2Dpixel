extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta):
	# 1) อ่านอินพุตในเฟรมฟิสิกส์
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()

	# 2) ตั้งค่า velocity แล้วขยับทันที
	velocity = direction * move_speed
	move_and_slide()

	# 3) อัปเดต state + ทิศ
	SetState()
	if direction != Vector2.ZERO:
		cardinal_direction = direction

	# 4) อัปเดตแอนิเมชัน
	UpdateAnimation()

func SetState() -> void:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state != state:
		state = new_state

func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())

func AnimDirection() -> String:
	if abs(cardinal_direction.x) > abs(cardinal_direction.y):
		return "right" if cardinal_direction.x > 0 else "left"
	else:
		return "down" if cardinal_direction.y > 0 else "up"
