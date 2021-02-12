extends RigidBody

const DAMAGE = 50
const SPEED = 100

func _ready():
	set_as_toplevel(true)
	

func shoot(delta):
	apply_impulse(transform.basis.z, -transform.basis.z * SPEED) 


func _on_Area_body_entered(body):
	if body.is_in_group("enemy"):
		body.Health -= DAMAGE
		queue_free()
	else:
		queue_free()
