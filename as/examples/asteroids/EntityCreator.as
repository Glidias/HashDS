package examples.asteroids
{
	import examples.asteroids.nodes.MovementNode;
	import flash.ui.Keyboard;
	import hashds.components.common.oneD.Age;
	import hashds.components.common.oneD.Rotation;
	import hashds.components.common.oneD.Size;
	import hashds.components.common.twoD.Position2;
	import hashds.game.Entity;
	import hashds.game.Game;

	import examples.asteroids.components.Display;
	import examples.asteroids.components.Gun;
	import examples.asteroids.components.GunControls;
	import examples.asteroids.components.Motion;
	import examples.asteroids.components.MotionControls;
	
	import examples.asteroids.graphics.AsteroidView;
	import examples.asteroids.graphics.BulletView;
	import examples.asteroids.graphics.SpaceshipView;


	public class EntityCreator
	{
		private var game : Game;
		
		public function EntityCreator( game : Game )
		{
			this.game = game;
		}
		
		public function destroyEntity( entity : Entity ) : void
		{
			game.removeEntity( entity );
		}

		public function createAsteroid( radius : Number, x : Number, y : Number ) : Entity
		{
			var asteroid : Entity = Entity.get();
			asteroid.typeMask |= MyCollisionGroups.ASTEROID;
			

			asteroid.addComponent( Position2.get(x,y) );

			asteroid.addComponent(Size.get(radius));
			

	
			asteroid.addComponent( Rotation.get( Math.random() * Math.PI*2) );
			
			var motion : Motion = Motion.get();
			motion.angularVelocity = Math.random() * 2 - 1;
			motion.velocity.x = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			motion.velocity.y = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			asteroid.addComponent( motion );

			var display : Display = new Display();
			display.displayObject = new AsteroidView( radius );
			asteroid.addComponent( display );

			game.addEntity( asteroid );
			return asteroid;
		}
		
	//public var control : MotionControls;
	//	public var position :Position2;
	//	public var motion : Motion;
	//	public var rotation:Rotation;
		
		public function createSpaceship(isClient:Boolean=true) : Entity
		{
			var spaceship : Entity = Entity.get();
			spaceship.typeMask |= MyCollisionGroups.SPACESHIP;
			spaceship.typeMask |= isClient ? MyCollisionGroups.PLAYER : 0;

			spaceship.addComponent( Position2.get(300, 225)  );
			spaceship.addComponent( Size.get(6) );
			spaceship.addComponent(Rotation.get(0));

			var motion : Motion =Motion.get();
			motion.damping = 15;
			spaceship.addComponent( motion );

			var motionControls : MotionControls = new MotionControls();
			motionControls.left = Keyboard.LEFT;
			motionControls.right = Keyboard.RIGHT;
			motionControls.accelerate = Keyboard.UP;
			motionControls.accelerationRate = 100;
			motionControls.rotationRate = 3;
			spaceship.addComponent( motionControls );

			var gun : Gun = new Gun();
			gun.minimumShotInterval = 0.3;
			gun.offsetFromParent.x = 8;
			gun.offsetFromParent.y = 0;
			gun.bulletLifetime = 2;
			spaceship.addComponent( gun );

			var gunControls : GunControls = new GunControls();
			gunControls.trigger = Keyboard.Z;
			spaceship.addComponent( gunControls );

			var display : Display = new Display();
			display.displayObject = new SpaceshipView();
			spaceship.addComponent( display );
			
			game.addEntity( spaceship );
			return spaceship;
		}

		public function createUserBullet( gun : Gun, parentPosition : Position2, parentRotation:Rotation ) : Entity
		{
			var bullet : Entity = Entity.get();
			bullet.typeMask |= MyCollisionGroups.PLAYER_BULLET;

			bullet.addComponent( Age.get(gun.bulletLifetime) );
			
			bullet.addComponent( Size.get(3) );
			
			bullet.addComponent(Rotation.get(0)); // todo: make rotation optional for movement node!

			var cos : Number = Math.cos( parentRotation.amount );
			var sin : Number = Math.sin( parentRotation.amount );

			bullet.addComponent( Position2.get(
				cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.x,
				sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.y
				)
			);

			var motion : Motion = Motion.get(cos*150, sin*150);
			bullet.addComponent( motion );

			var display : Display = new Display();
			display.displayObject = new BulletView();
			bullet.addComponent( display );

			game.addEntity( bullet );
			return bullet;
		}
	}
}
