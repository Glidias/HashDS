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

	
	@field public inline function get(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) );
	}
	
	@field public inline function set(index:Int, val:Float):Void {
		Memory.setFloat(_mem.offset + (index << BLOCK_SHIFT), val );
	}
	
}