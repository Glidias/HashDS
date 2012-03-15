package hashds.game.alchemy;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;
import hashds.game.alchemy.ds.MemoryDS;
import hashds.game.ComponentID;

/**
 * A component that acts on behalf of a data structure itself that exists in alchemy memory with
 * fixed per-block size, rather than as an instance. Multiple components of the same block size can share the same
 * MemoryDS access buffer.
 * @author Glenn Ko
 */

class A_Component extends A_Base
{
	public var _index:Int;
	
	
	public function new(name:String=null) 
	{
		super();
		ComponentLookup.registerComponent(this);
	}
	public inline function init(allocateNumBlocks:Int, allocateAvailIndices:Int, useExistingMem:Bool=false, existingMem:MemoryDS=null):Void {
		_init(allocateNumBlocks, allocateAvailIndices, useExistingMem, existingMem);
	}
	
	public inline function _dispose(addr:Int):Void {
		_mem.freeAddr(addr);
	}
	
	public function getKey():String {  // todo: get a unique hash key for component
		return "";
	}
	


	

	
	
	
	

	
	
}