package hashds.game.alchemy.components.common;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import flash.Memory;
import hashds.game.alchemy.A_Component;

/**
 * ...
 * @author Glenn Ko
 */

class A_Tuple3 extends A_Component
{

	public static inline var BLOCK_SIZE:Int = 12;


	public function new(name:String=null) 
	{
		super(name);
		_blockSize = BLOCK_SIZE;
	}
	
	public inline function add(hash:IntIntHashTable, x:Float=0, y:Float=0, z:Float=0):Void {
		var addr:Int = getAvailableAddress();
		hash.set(_id, addr);
		set(addr, x, y, z);
	}
	/*
	override public function addDefault(hash:IntIntHashTable):Bool {
		add(hash);
		return true;
	}
	*/
	@field public inline function get_x(addr:Int):Float {
		return Memory.getFloat(addr);
	}
	@field public inline function get_y(addr:Int):Float {
		return Memory.getFloat(addr + 4);
	}
	@field public inline function get_z(addr:Int):Float {
		return Memory.getFloat(addr + 8);
	}
	public inline function set_x(addr:Int, val:Float):Void {
		 Memory.setFloat(addr, val);
	}
	public inline function set_y(addr:Int, val:Float):Void {
		 Memory.setFloat(addr +4, val);
	}
	public inline function set_z(addr:Int, val:Float):Void {
		 Memory.setFloat(addr +8, val);
	}
	
	public inline function set(addr:Int, x:Float, y:Float, z:Float):Void {
		set_x(addr, x);
		set_y(addr, y);
		set_z(addr, z);
	}
	
}