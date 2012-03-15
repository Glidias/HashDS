package hashds.game.alchemy.components.common;
import flash.Memory;
import hashds.game.alchemy.A_Component;

/**
 * ...
 * @author Glenn Ko
 */

class A_Float extends A_Component
{
	public static inline var BLOCK_SHIFT:Int = 2;
	public static inline var BLOCK_SIZE:Int = (1 << BLOCK_SHIFT);

	public function new() 
	{
		super();
		_blockSize = BLOCK_SIZE;
	}
	
	public inline function create(val:Float):Void {
		var index:Int = getAvailableAddress();
		set(index, val);
	}

	
	@field public inline function get(addr:Int):Float {
		return Memory.getFloat(addr);
	}
	
	public inline function set(addr:Int, val:Float):Void {
		Memory.setFloat(addr, val);
	}
	
	
}