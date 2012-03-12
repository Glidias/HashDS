package examples.asteroids.components
{
	import hashds.game.ComponentID;
	public class MotionControls
	{
		public static var ID:int = ComponentID.next();
		
		public var left : uint = 0;
		public var right : uint = 0;
		public var accelerate : uint = 0;
		
		public var accelerationRate : Number = 0;
		public var rotationRate : Number = 0;
	}
}
