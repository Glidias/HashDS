package hashds.game.alchemy;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glenn Ko
 */

class A_Component extends A_Base
{
	private var _id:Int;
	public inline function getId():Int {
		return _id;
	}

	public function new() 
	{
		super();
		_id = ComponentID.next();
	}
	
}