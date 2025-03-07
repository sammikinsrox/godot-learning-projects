extends Node


signal on_create_bullet(position: Vector2, direction: Vector2, speed: float, bullet_type: BaseBullet.BulletType)
signal on_create_powerup(position: Vector2, power_up_type: PowerUp.PowerUpType)
signal on_create_explosion(pos: Vector2, et: Explosion.ExplosionType)
