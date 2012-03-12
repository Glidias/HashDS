package examples.asteroids.systems
{
	import examples.asteroids.nodes.LifeNode;
	import flash.utils.Dictionary;
	import hashds.components.common.oneD.Age;
	import hashds.ds.SLifePoolList_examples_asteroids_nodes_LifeNode;
	import hashds.game.Game;
	import hashds.game.NodeList;
	import hashds.game.GameSystem;
	import examples.asteroids.EntityCreator;


	public class AgeSystem extends GameSystem
	{
		private var creator : EntityCreator;
		
		private var nodes : SLifePoolList_examples_asteroids_nodes_LifeNode;
		private var _game:Game;

		public function AgeSystem(  )
		{
	
		}

		override public function addToGame( game : Game ) : void
		{
			this._game = game;
			nodes = game.getDataStructure( SLifePoolList_examples_asteroids_nodes_LifeNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : LifeNode;
			var age : Age;
			var next:LifeNode;
			
		
			var last:LifeNode;
			for ( node = nodes.head; node; node = next )
			{
				next = node.next;
				age = node.age;
				age.life -= time;
				if ( node.dead || age.life <= 0 )
				{
					_game.removeEntity(node.entity); 
					if (last != null) {
						last.next = next;
					}
					else nodes.head = next;
				}
				last = node;
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
			_game = null;
		}
	}
}
