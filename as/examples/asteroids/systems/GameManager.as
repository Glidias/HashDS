package examples.asteroids.systems
{
	import examples.asteroids.GameState;
	import examples.asteroids.MyCollisionGroups;
	import examples.asteroids.nodes.RadialCollisionNode;
	import flash.geom.Point;
	import hashds.ds.DLMixList_examples_asteroids_nodes_RadialCollisionNode;
	import hashds.game.Game;
	import hashds.game.NodeList;
	import hashds.game.GameSystem;
	import examples.asteroids.EntityCreator;
	import examples.asteroids.GameState;



	public class GameManager extends GameSystem
	{
		private var gameState : GameState;
		private var creator : EntityCreator;
		
		private var spaceships : DLMixList_examples_asteroids_nodes_RadialCollisionNode;
		private var asteroids : DLMixList_examples_asteroids_nodes_RadialCollisionNode;
		private var bullets : DLMixList_examples_asteroids_nodes_RadialCollisionNode;

		public function GameManager( gameState : GameState, creator : EntityCreator )
		{
			this.gameState = gameState;
			this.creator = creator;
		}

		override public function addToGame( game : Game ) : void
		{
			spaceships = MyCollisionGroups.SPACESHIPS_ALL.getDataStructure();
			asteroids =MyCollisionGroups.ASTEROIDS_ALL.getDataStructure();
			bullets =MyCollisionGroups.PLAYER_BULLETS.getDataStructure();
		}
		
		public static function getSquaredRadius(radius:Number):Number
		{
			var a:Number = Math.sin(Math.PI * .125) * radius;
			var b:Number = Math.cos(Math.PI * .125) * radius;
			return a * a + b * b;
		}
		
		override public function update( time : Number ) : void
		{
			if( spaceships.head == null )
			{
				if( gameState.lives > 0 )
				{
			
					var newSpaceshipPosition : Point = new Point( gameState.width * 0.5, gameState.height * 0.5 );
					var asteroidPos:Point = new Point();
					var clearToAddSpaceship : Boolean = true;
					for( var asteroid : RadialCollisionNode = asteroids.head; asteroid; asteroid = asteroid.next )
					{
						asteroidPos.x = asteroid.position.x;
						asteroidPos.y= asteroid.position.y;
						if( Point.distance( asteroidPos, newSpaceshipPosition ) <= asteroid.size.radius + 50 )
						{
							clearToAddSpaceship = false;
							break;
						}
					}
					if( clearToAddSpaceship )
					{
						creator.createSpaceship();
						gameState.lives--;
					}
				}
				else
				{
					// game over
				}
			}
			
			const SQ_RADIUS:Number = getSquaredRadius(80);
			
			if( asteroids.head==null && bullets.head==null && spaceships.head!=null )
			{
				// next level
				var spaceship : RadialCollisionNode = spaceships.head;
				gameState.level++;
				var asteroidCount : int = 2 + gameState.level;
				for( var i:int = 0; i < asteroidCount; ++i )
				{
	
					
					x = Math.random() * gameState.width
					y = Math.random() * gameState.height;
					var x:Number = spaceship.position.x - x;
					var y:Number = spaceship.position.y - y;
					var sqD:Number = x * x + y * y;
					while (sqD < SQ_RADIUS) {
						x = Math.random() * gameState.width
						y = Math.random() * gameState.height;
						x = spaceship.position.x - x;
						y = spaceship.position.y - y;
						sqD = x * x + y * y;
					}
					creator.createAsteroid( 30, x, y );
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
