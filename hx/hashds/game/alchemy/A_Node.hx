package hashds.game.alchemy;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;
import flash.Memory;

/**
 * A node that is simply nothing more than a data structure itself in alchemy memory with
 * a fixed per-block size. Due to the fact that a node is meant for contigous data set iteration within a process, each node
 * should have it's own unique reserved MemoryDS buffer space to avoid lumping different processes together. By default,
 * a node contains an entity index id header.
 * 
 * @author Glenn Ko
 */

class A_Node extends A_Base
{

	private static inline var HEADER_SIZE:Int = 4; 
	private var _len:Int;
	
	private var _entityHash:IntIntHashTable;
	
	public inline function getLen():Int {
		return _len;
	}
	
	public function new() 
	{
		super();
	}
	
	/**
	 * 
	 * @param	allocateNumBlocks		The total number of nodes you wish to allocate.
	 * @param	allocateAvailIndices	The estimated total number pooled nodes you're bound to have.
	 * @param	entityHash				The family's intInthash table used to allow an entity's unique key id to point to the correct memory address within this node.
	 */
	public inline function init(allocateNumBlocks:Int, allocateAvailIndices:Int, entityHash:IntIntHashTable):Void {
		_init(allocateNumBlocks, allocateAvailIndices);
		_entityHash = entityHash;
	}
	
	
	// For clarity ... good for iteration, get start addr and end address, assuming mem.offset or usedBytes doesn't change during iteration
	// , a possible way includes getting start and end point address, and += getBlockSize() value.
	public inline function getDSAddrStart():Int {
		return getMemoryOffset() + HEADER_SIZE;
	}
	public inline function getDSAddrEnd():Int {
		return getDSAddrStart() + getUsedBytes();
	}
	public inline function getDSAddrLength():Int {
		return getUsedBytes();
	}	
	
	private inline function _getEntityHeader(addr:Int):Int {
		return Memory.getI32(addr);
	}
	private inline function _setEntityHeader(addr:Int, val:Int):Void {
		Memory.setI32(addr, val);
	}
	
	// WARNING: This internal method is not meant to be called by systems directly, but through the family that manages this node! 
	public inline function _dispose(addr:Int):Void {
		// METHOD 1: Passive deletion. Prefably, systems would call compact() prior to iterating through the node list, and ignore dead nodes during iteration.
		markAsDead(addr);   // mark an address as dead so it can be ignored by systems during iteration.
		_mem.freeAddr(addr);  
			
		// METHOD 2: Active deletion (but have to re-iterate over missed addresses!, a bit complicated)
		// hmmmm.....
	}
	
	public inline function markAsDead(addr:Int):Void {
		_setEntityHeader(addr, 0);
	}
	public inline function isDead(addr:Int):Bool {
		return _getEntityHeader(addr) == 0;
	}
	public inline function isAlive(addr:Int):Bool {
		return _getEntityHeader(addr) != 0;
	}
	
	
	// Public cleanup strategies for systems (since nodes should be compacted to avoid/minimize running across dead nodes
	
	public inline function compact():Void {
		var i:Int = _mem.getAvailAddrUsageCount();
		var addr:Int = _mem.getAvailAddrOffset() + i * _blockSize  - _blockSize;  // tailAddress
		var tail:Int = getTailAddress();
		while (--i > -1) {
			SpliceOrPopBack( Memory.getI32(addr), tail );  // in either case, popUsage(), which should cleanup the usage length to iterate through
			addr -= _blockSize;
		}
		_mem.resetAvailAddrUsage();
	}
	
	// The process of iterating through nodes, and splicing them within the iteration loop, checking for potential misses, hmm..not reccomended
	/*
	public inline function spliceOrPopBackInclude(addr:Int, currentAddr:Int, precomputedTailAddress:Bool=false, precomputeTail:Int=0):Void {
		if (currentAddr > addr) {  // a miss has occured, record this
			_mem.freeAddr(addr);
		}
		if (precomputedTailAddress) {
			SpliceOrPopBack(addr, precomputeTail);
		}
		else {
			spliceOrPopBack(addr);
		}
	}
	*/
	
	public inline function spliceOrPopBack(addr:Int):Void {
		SpliceOrPopBack(addr, getTailAddress());
	}
	
	// The splice and pop back strategy method  (popping-backs requires shifting1 entity, so only that entity's index hashed address value must be updated)
	public inline function SpliceOrPopBack(addr:Int, tail:Int):Void {
		if (tail != addr) {    
			// do a pop back routine, as currently deleted address is behind tail, fill deleted address with block data at tail address.
			var end:Int = addr + _blockSize;
			for (i in addr...end) {
				Memory.setByte(i, Memory.getByte(tail+i));
			}
			// due to moving of block data from tail to new address, the entity header index at that new address must be updated togeter with the Family's hash.
			_entityHash.set( _getEntityHeader(addr), addr);
			_mem.popUsage(_blockSize);
		}
		else {	// pop only
			_mem.popUsage(_blockSize);
		}
	}
	
	
}