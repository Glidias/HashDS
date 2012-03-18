package hashds.game.alchemy;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import flash.errors.Error;
import flash.Memory;
import hashds.ds.ISLMixNode;
import hashds.ds.ISLMixNode;
import hashds.game.alchemy.A_Node;
import hashds.game.alchemy.ds.MemoryDS;
import haxe.rtti.Meta;

/**
 * 
 * @author Glenn Ko
 */

class A_Family implements ISLMixNode<A_Family>
{
	private var _node:A_Node;
	private var _entHash:IntIntHashTable;

	 // ordered indices of node component references
	private var _cIndices:IntMemory; 
	private var _cLen:Int;
	
	public var next:A_Family;
	private var _numComponents:Int;

	public function new(node:A_Node, allocateNumBlocks:Int, allocateAvailIndices:Int, slotCount:Int=4, capacity:Int=-1) 
	{
		_node = node;
		_entHash = new IntIntHashTable(slotCount, capacity);
		
		node.init(allocateNumBlocks, allocateAvailIndices, _entHash);
		_reflectNode(node);
		
		
	}
	
	private function _reflectNode(node:A_Node):Void {
		_numComponents = ComponentLookup.injectComponentsInto(node);
		_cIndices = new IntMemory(_numComponents, _node + "_componentIndices");
		var orderedItems:Array<Dynamic> = node.getOrderedComponents();
		if (orderedItems.length != _numComponents) throw new Error("Mismatch of getOrderedComponents() vs meta-fields component length!" + orderedItems.length + "/" + _numComponents);
		var len:Int = orderedItems.length;
		for (i in 0...len) {
			_cIndices.set(i, orderedItems[i].getId() );
		}
	}
	
	public inline function _matchTable(hash:IntIntHashTable):Bool {
		var result:Bool = true;
		for (i in 0..._cLen) {
			if ( !hash.hasKey( _cIndices.get(i) ) ) {
				result = false;
				break;
			}
		}
		return result;
	}
	
	public inline function _addIfMatchTable(hash:IntIntHashTable):Void {
		if (_matchTable(hash)) {
			_confirmAdd(hash);
		}
	}
	
	public inline function _confirmAdd(hash:IntIntHashTable):Void {
		var mem:MemoryDS = _node._mem;
		var addr:Int =  _node.getAvailableAddress();
		for (i in 0..._cLen) {
			Memory.setI32( addr + (i<<2), hash.get( _cIndices.get(i) ) );
		}
		_entHash.set(hash.key, addr);
	}
	
	public inline function _contains(key:Int):Bool {
		return _entHash.hasKey(key);
	}
	
	public inline function _removeEntIfContains(key:Int):Void {
		if (_contains(key)) {
			_confirmRemove(key);
		}
	}
	
	public inline function _confirmRemove(key:Int):Void {
		_node._dispose(  _entHash.get(key) );
		_entHash.remove(key);
	}
	
}