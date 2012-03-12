package examples.asteroids.systems
{
	import examples.asteroids.input.KeyPoll;
	import hashds.components.common.oneD.Rotation;
	import hashds.components.common.twoD.Position2;
	import hashds.game.Game;
	import hashds.game.NodeList;
	import hashds.game.GameSystem;
	import examples.asteroids.components.Motion;
	import examples.asteroids.components.MotionControls;
	import examples.asteroids.nodes.MotionControlNode;
	import examples.asteroids.input.KeyPoll;

	public class MotionControlSystem extends GameSystem
	{
		private var keyPoll : KeyPoll;
		
		private var nodes : NodeList;

		public function MotionControlSystem( keyPoll : KeyPoll )
		{
			this.keyPoll = keyPoll;
		}

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getDataStructure( MotionControlNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : MotionControlNode;
			var control : MotionControls;
			var position : Position2;
			var rot : Rotation;
			var motion : Motion;
			

			for ( node = nodes.head; node; node = node.next )
			{
				
				control = node.control;
				position = node.position;
				motion = node.motion;
				rot = node.rotation;

				if ( keyPoll.isDown( control.left ) )
				{
					rot.amount -= control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.right ) )
				{
					rot.amount += control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.accelerate ) )
				{
					motion.velocity.x += Math.cos( rot.amount ) * control.accelerationRate * time;
					motion.velocity.y += Math.sin( rot.amount ) * control.accelerationRate * time;
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
