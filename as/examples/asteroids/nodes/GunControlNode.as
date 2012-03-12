package examples.asteroids.nodes
{
	import hashds.components.common.oneD.Rotation;
	import hashds.components.common.twoD.Position2;
	import hashds.game.Node;
	import examples.asteroids.components.Gun;
	import examples.asteroids.components.GunControls;


	public class GunControlNode extends Node
	{
		public var control : GunControls;
		public var gun : Gun;
		public var position : Position2;
		public var rotation:Rotation;
	}
}
