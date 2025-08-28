class_name Player extends CharacterBody2D

var move_speed : float = 100.0

#Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process( delta ):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	velocity = direction * move_speed
	
	pass
	
func  _physics_process( delta ):
	move_and_slide()
