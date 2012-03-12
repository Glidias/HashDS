package examples.asteroids.systems
{
	import examples.asteroids.input.KeyPoll;
	import hashds.components.common.twoD.Position2;
	import hashds.game.Game;
	import hashds.game.GameSystem;
	import hashds.game.NodeList;
	import examples.asteroids.EntityCreator;
	import examples.asteroids.components.Gun;
	import examples.asteroids.components.GunControls;

	import examples.asteroids.nodes.GunControlNode;
	import examples.asteroids.input.KeyPoll;

	public class GunControlSystem extends GameSystem
	{
		private var keyPoll : KeyPoll;
		private var creator : EntityCreator;
		
		private var nodes : NodeList;

		public function GunControlSystem( keyPoll : KeyPoll, creator : EntityCreator )
		{
			this.keyPoll = keyPoll;
			this.creator = creator;
		}

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getDataStructure( GunControlNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : GunControlNode;
			var control : GunControls;
			var position : Position2;
			var gun : Gun;

			for ( node = nodes.head; node; node = node.next )
			{
				control = node.control;
				gun = node.gun;
				position = node.position;

				gun.shooting = keyPoll.isDown( control.trigger );
				gun.timeSinceLastShot += time;
				if ( gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval )
				{
					creator.createUserBullet( gun, position, node.rotation );
					gun.timeSinceLastShot = 0;
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
