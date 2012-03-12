package hashds.components.common.oneD;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Alpha 
{
	public static var ID:Int = ComponentID.next();		
	public var amount:Float;
	
	public function new() 
	{
		
	}
	
	inline public static function get(amount:Float):Alpha {
		var me:Alpha = new Alpha();
		me.amount = amount;
		return me;
	}

	
}