package hashds.components.common.oneD;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Size 
{
	public static var ID:Int = ComponentID.next();		
	public var radius:Float;
	
	public function new() 
	{
		
	}
	
	inline public static function get(radius:Float):Size {
		var me:Size = new Size();
		me.radius = radius;
		return me;
	}

	
}