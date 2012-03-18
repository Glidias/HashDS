package hashds.game.alchemy.components.common;
import de.polygonal.ds.IntIntHashTable;
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

	public function new(name:String=null) 
	{
		super(name);
		_blockSize = BLOCK_SIZE;
	}
	
	public inline function add(hash:IntIntHashTable, val:Float):Void {
		var addr:Int = getAvailableAddress();
		hash.set(_id, addr);
		set(addr, val);
	}
	/*
	override public function addDefault(hash:IntIntHashTable):Bool {
		add(hash, 0);	
		return true;
	}
	*/

	
	@field public inline function get(addr:Int):Float {
		return Memory.getFloat(addr);
	}
	
	public inline function set(addr:Int, val:Float):Void {
		Memory.setFloat(addr, val);
	}
	
	
}