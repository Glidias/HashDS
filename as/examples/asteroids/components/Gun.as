package examples.asteroids.components
{
	import flash.geom.Point;
	import hashds.game.ComponentID;
	
	public class Gun
	{
		public static var ID:int = ComponentID.next();
		
		public var shooting : Boolean = false;
		public var offsetFromParent : Point = new Point();
		public var timeSinceLastShot : Number = 0;
		public var minimumShotInterval : Number = 0;
		public var bulletLifetime : Number = 0;
	}
}
