package hashds.game.alchemy.components.common;
import flash.Memory;
import hashds.game.alchemy.A_Component;

/**
 * ...
 * @author Glenn Ko
 */

class A_Tuple2 extends A_Component
{

	public static inline var BLOCK_SHIFT:Int = 3;
	public static inline var BLOCK_SIZE:Int = (1 << BLOCK_SHIFT);
	
	public function new() 
	{
		super();
		_blockSize = BLOCK_SIZE;
	}
	
	public inline function create(x:Float, y:Float):Void {
		var addr:Int = getAvailableAddress();
		set(addr, x, y);
	}
	
	@field public inline function get_x(addr:Int):Float {
		return Memory.getFloat(addr);
	}
	@field public inline function get_y(addr:Int):Float {
		return Memory.getFloat(addr+4);
	}
	public inline function set_x(addr:Int, val:Float):Void {
		Memory.setFloat(addr, val);
	}
	public inline function set_y(addr:Int, val:Float):Void {
		Memory.setFloat(addr+4, val);
	}

	public inline function set(addr:Int, x:Float, y:Float):Void {
		set_x(addr, x);
		set_y(addr, x);
	}
		
	
}