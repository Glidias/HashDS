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
		return getX(_mem.offset, index);
	}
	@field public inline function get_y(index:Int):Float {
		return getY(_mem.offset, index);
	}
	public inline function set_x(index:Int, val:Float):Void {
		setX(_mem.offset, index, val);
	}
	public inline function set_y(index:Int, val:Float):Void {
		setY(_mem.offset, index, val);
	}

	
	public inline function getX(offset:Int, index:Int):Float {
		return Memory.getFloat( offset + (index << BLOCK_SHIFT) );
	}
	public inline function getY(offset:Int, index:Int):Float {
		return Memory.getFloat( offset + (index << BLOCK_SHIFT) + 1 );
	}

	public inline function setX(offset:Int, index:Int, val:Float):Void {
		Memory.setFloat( offset + (index << BLOCK_SHIFT), val );
	}
	public inline function setY(offset:Int, index:Int, val:Float):Void {
		Memory.setFloat( offset + (index << BLOCK_SHIFT) + 1, val );
	}
	
	
	public inline function set(index:Int, x:Float, y:Float):Void {
		setXY(_mem.offset, index, x, y);
	}
	
	public inline function setXY(offset:Int, index:Int, x:Float, y:Float):Void {
		setX(offset, index,x);
		setY(offset, index,y);
	}

	
	
	
}