package examples.asteroids.nodes
{
	import hashds.components.common.oneD.Rotation;
	import hashds.components.common.twoD.Position2;
	import hashds.game.Node;
	import examples.asteroids.components.Motion;
	import examples.asteroids.components.MotionControls;
	

	public class MotionControlNode extends Node
	{
		public var control : MotionControls;
		public var position :Position2;
		public var motion : Motion;
		public var rotation:Rotation;
	}
}
