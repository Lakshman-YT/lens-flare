extends Spatial

onready var muzzle = $Muzzle
onready var cam_cast = $"../../Camera/cam_cast"
onready var bull = preload("res://Bullet/Bullet.tscn")

onready var Head = $"../../"

var can_fire = true

var up_recoil = 0 
var fire = false

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		if cam_cast.is_colliding():
			var bullet = bull.instance()
			muzzle.add_child(bullet)
			bullet.look_at(cam_cast.get_collision_point(), Vector3.UP)
			bullet.shoot(delta)
			
			fire = true
			
			can_fire = false
			yield(get_tree().create_timer(0.25) ,"timeout")
			can_fire = true
			
			fire = false

	if fire:
		var side_recoil = rand_range(-5, 5)
		var recoil = rand_range(3, 5)
		up_recoil += recoil * delta
		Head.rotation.x = lerp( Head.rotation.x , deg2rad(Head.rotation_degrees.x + up_recoil ) ,delta )
		Head.rotation.y = lerp( Head.rotation.y , deg2rad(side_recoil ) ,  3 * delta )
		if up_recoil >= 35:
			up_recoil = 35
		
	if ! Input.is_action_pressed("fire") and can_fire:
		up_recoil = 0



