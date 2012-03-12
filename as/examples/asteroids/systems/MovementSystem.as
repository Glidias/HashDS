package examples.asteroids.systems
{
	import hashds.components.common.oneD.Rotation;
	import hashds.components.common.twoD.Position2;
	import hashds.ds.DLMixList_examples_asteroids_nodes_MovementNode;
	import hashds.game.Game;
	import hashds.game.NodeList;
	import hashds.game.GameSystem;
	import examples.asteroids.components.Motion;

	import examples.asteroids.nodes.MovementNode;

	public class MovementSystem extends GameSystem
	{
		private var nodes : DLMixList_examples_asteroids_nodes_MovementNode;

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getDataStructure( DLMixList_examples_asteroids_nodes_MovementNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : MovementNode;
			
			var position : Position2;
			var motion : Motion;
			var rotation:Rotation;

			for ( node = nodes.head; node; node = node.next )
			{
				position = node.position;
				motion = node.motion;
				rotation = node.rotation;
				
				
				
				position.x += motion.velocity.x * time;
				position.y += motion.velocity.y * time;
				if ( position.x < 0 )
				{
					position.x += 600;
				}
				if ( position.x > 600 )
				{
					position.x -= 600;
				}
				if ( position.y < 0 )
				{
					position.y += 450;
				}
				if ( position.y > 450 )
				{
					position.y -= 450;
				}
				rotation.amount += motion.angularVelocity * time;
				if ( motion.damping > 0 )
				{
					var xDamp : Number = Math.abs( Math.cos( rotation.amount ) * motion.damping * time );
					var yDamp : Number = Math.abs( Math.sin( rotation.amount ) * motion.damping * time );
					if ( motion.velocity.x > xDamp )
					{
						motion.velocity.x -= xDamp;
					}
					else if ( motion.velocity.x < -xDamp )
					{
						motion.velocity.x += xDamp;
					}
					else
					{
						motion.velocity.x = 0;
					}
					if ( motion.velocity.y > yDamp )
					{
						motion.velocity.y -= yDamp;
					}
					else if ( motion.velocity.y < -yDamp )
					{
						motion.velocity.y += yDamp;
					}
					else
					{
						motion.velocity.y = 0;
					}
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
