package examples.asteroids.components;
import flash.geom.Point;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Motion 
{
	public static var ID:Int = ComponentID.next();		
	
	public var velocity : Point;
	public var angularVelocity : Float;
	public var damping : Float;
	
	public function new() 
	{
		
	}
	
	public static inline function get(vx:Float=0, vy:Float=0,angVel:Float=0, damping:Float=0):Motion {
		var me:Motion = new Motion();
		me.velocity = new Point(vx, vy);
		me.angularVelocity = 0;
		me.damping = 0;
		return me;
	}
	
}