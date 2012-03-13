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
			
		
			// Why singly-linked list sucks...
			var last:LifeNode;
			for ( node = nodes.head; node; node = next )
			{
				next = node.next;  // boiler
				
				if (node.dead) {  // inline unhook boilerplate
					if (last != null) {
						last.next = next;
					}
					else nodes.head = next;
					
					nodes.pool.putBack(node);
					continue;
				}
				
				// Process
				age = node.age;
				age.life -= time;
				
	
				if ( age.life <= 0 )   // inline unhook boilerplate + notify game to remove entity!
				{
					_game.removeEntity(node.entity); 
					if (last != null) {
						last.next = next;
					}
					else nodes.head = next;
					
					nodes.pool.putBack(node);
					continue;
				}
				
	
				last = node;  // boiler
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
			_game = null;
		}
	}
}
