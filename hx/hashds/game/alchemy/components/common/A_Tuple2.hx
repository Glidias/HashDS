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
	
	@field public inline function get_x(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) );
	}
	@field public inline function get_y(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) + 1 );
	}
	
	
	public inline function set_x(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT), val );
	}
	public inline function set_y(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT) + 1, val );
	}
	
	
	public inline function set(index:Int, x:Float, y:Float):Void {
		set_x(index,x);
		set_y(index,y);
	}

	
	
	
}