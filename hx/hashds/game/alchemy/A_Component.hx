package hashds.game.alchemy;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;
import hashds.game.alchemy.ds.MemoryDS;
import hashds.game.ComponentID;

/**
 * A component that acts on behalf of a data structure itself that exists in alchemy memory with
 * fixed per-block size, rather than as an instance per block. Multiple components of the same block size can share the same
 * MemoryDS access buffer.
 * @author Glenn Ko
 */

class A_Component extends A_Base, implements IComponentDS
{
	private var _id:Int;
	private var _name:String;
	
	public function new(name:String=null) 
	{
		super();
		_name = name;
		_id = ComponentLookup.registerComponent(this);
	}
	/*
	public function addDefault(hash:IntIntHashTable):Bool {
		return false;
	}
	*/
	
	public inline function init(allocateNumBlocks:Int, allocateAvailIndices:Int, useExistingMem:Bool=false, existingMem:MemoryDS=null):Void {
		_init(allocateNumBlocks, allocateAvailIndices, useExistingMem, existingMem);
	}
	
	public inline function _dispose(addr:Int):Void {
		_mem.freeAddr(addr);
	}
	
	public function free(key:Int):Void {
		_mem.freeAddr(key);
	}
	

	public function getId():Int {
		return _id;
	}
	
	public function getName():String 
	{
		return _name;
	}

	
	
}