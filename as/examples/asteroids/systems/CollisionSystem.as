package examples.asteroids.systems
{
	import examples.asteroids.MyCollisionGroups;
	import examples.asteroids.nodes.RadialCollisionNode;
	import flash.geom.Point;
	import hashds.components.common.twoD.Position2;
	import hashds.ds.DLMixList_examples_asteroids_nodes_RadialCollisionNode;
	import hashds.game.family.DLMixListFamily_examples_asteroids_nodes_RadialCollisionNode;
	import hashds.game.Game;
	import hashds.game.NodeList;
	import hashds.game.GameSystem;
	import examples.asteroids.EntityCreator;
	import hashds.game.nodes.DLEntNode_examples_asteroids_nodes_RadialCollisionNode;


	public class CollisionSystem extends GameSystem
	{
		private var creator : EntityCreator;
		
		private var spaceships : DLMixList_examples_asteroids_nodes_RadialCollisionNode;
		private var asteroids : DLMixList_examples_asteroids_nodes_RadialCollisionNode;
		private var bullets : DLMixList_examples_asteroids_nodes_RadialCollisionNode;

		public function CollisionSystem( creator : EntityCreator )
		{
			this.creator = creator;
		}

		override public function addToGame( game : Game ) : void
		{
			spaceships = MyCollisionGroups.SPACESHIPS_ALL.getDataStructure();
			asteroids = MyCollisionGroups.ASTEROIDS_ALL.getDataStructure();
			bullets = MyCollisionGroups.PLAYER_BULLETS.getDataStructure();
		}
		
		override public function update( time : Number ) : void
		{
			var bullet : RadialCollisionNode;
			var asteroid : RadialCollisionNode;
			var spaceship : RadialCollisionNode;
			
			var sqRadius:Number;
			var sqDist:Number;
			var a:Position2;
			var b:Position2;
			var x:Number;
			var y:Number;
			

			for ( bullet = bullets.head; bullet; bullet = bullet.next )
			{
				
				for ( asteroid = asteroids.head; asteroid; asteroid = asteroid.next )
				{
					sqRadius = asteroid.size.radius;
					sqRadius *= sqRadius;
					a = asteroid.position;
					b = bullet.position;
					x = b.x - a.x;
					y = b.y - a.y;
					if ( x*x + y*y <= sqRadius )
					{
						creator.destroyEntity( bullet.entity );
						if ( asteroid.size.radius > 10 )
						{
							creator.createAsteroid( asteroid.size.radius - 10, asteroid.position.x + Math.random() * 10 - 5, asteroid.position.y + Math.random() * 10 - 5 );
							creator.createAsteroid( asteroid.size.radius - 10, asteroid.position.x + Math.random() * 10 - 5, asteroid.position.y + Math.random() * 10 - 5 );
						}
						creator.destroyEntity( asteroid.entity );
						break;
					}
				}
			}

			for ( spaceship = spaceships.head; spaceship; spaceship = spaceship.next )
			{
				for ( asteroid = asteroids.head; asteroid; asteroid = asteroid.next )
				{
					sqRadius =asteroid.size.radius + spaceship.size.radius;
					sqRadius *= sqRadius;
					a = asteroid.position;
					b = spaceship.position;
					x = b.x - a.x;
					y = b.y - a.y;
					if ( x*x + y*y  <= sqRadius )
					{
						creator.destroyEntity( spaceship.entity );
						break;
					}
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			spaceships = null;
			asteroids = null;
			bullets = null;
		}
	}
}
