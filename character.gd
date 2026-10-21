extends Node2D
var hunt = false
var speed = 60
var direction = 1
var countdown = 0
@onready var animation = $AnimatedSprite2D
@onready var right = $right_ray
@onready var left = $left_ray
@onready var hitbox =$hitbox
@onready var clock = $"../clock"
@onready var player = get_tree().get_first_node_in_group("player")
func _process(delta):
	if right.is_colliding() and right.get_collider() != player:
		direction = -1
		animation.flip_h = true
	if left.is_colliding() and left.get_collider() != player:
		direction = 1
		animation.flip_h = false
	if right.is_colliding() and right.get_collider()==player:
		direction = 1
		animation.flip_h = false
		hunt = true
	if left.is_colliding() and left.get_collider()==player:
		direction = -1
		animation.flip_h = true
		hunt = true
	if hunt == true:
			if countdown < 14.0:
				countdown += delta
			if countdown < 11.0:
				animation.play("idle")
			else:
				animation.play("attack")
				position.x += speed * direction * delta
			if countdown >= 14.0:
				hunt = false
	if hunt != true:
		countdown = 0.0
		animation.play("run")
		speed = 60
		position.x += direction * speed * delta
