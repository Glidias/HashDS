package hashds.components.common.oneD;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Size 
{
	public static var ID:Int = ComponentID.next();		
	public var size:Float;
	
	public function new() 
	{
		
	}
	
	inline public static function get(size:Float):Size {
		var me:Size = new Size();
		me.size = size;
		return me;
	}

	
}