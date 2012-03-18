package hashds.game.alchemy.components.ds;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import flash.display.DisplayObject;
import flash.Vector;
import hashds.game.alchemy.ComponentLookup;
import hashds.game.alchemy.IComponentDS;
import haxe.rtti.Generic;

/**
 * Vector component data struture boiler-plate Generic class for storing strictly typed non-primitive data object references
 * in a vector. For data types that can be broken down into just numbers/integers, consider using using
 * @author Glenn Ko
 */

class VectorComponent<T> implements Generic, implements IComponentDS
{
	private var _list:Vector<T>;
	private var _len:Int;  // the size of the vector
	private var _useIndex:Int;  // last used index at tail
	private var _availIndices:IntMemory;
	private var _ai:Int;
	
	private var _id:Int;
	private var _name:String;
	
	public function new(name:String=null, vectorSize:Int=0, vectorFixed:Bool=false, availIndicesAllocate:Int=0) 
	{
		_name = name;
		_id = ComponentLookup.registerComponent(this);
		
		_list = new Vector<T>(vectorSize, vectorFixed);
		_len = vectorSize;
		_availIndices = new IntMemory(availIndicesAllocate, name + "_INDICES");
		_ai = 0;
		_useIndex = -1;
	}
	
	
	public inline function add(hash:IntIntHashTable, item:T):Void {
		var index:Int = _ai != 0 ?  _availIndices.get(--_ai) : ++_useIndex < _len ? _useIndex : _len++; 
		hash.set(_id, index);
		_list[index] = item;
	}
	
	public inline function get(index:Int):T {
		return _list[index];
	}
	
	/* INTERFACE hashds.game.alchemy.IComponentDS */
	
	public inline function _free(key:Int):Void 
	{
		_availIndices.set(_ai++, key);
	}
	
	public function getId():Int 
	{
		return _id;
	}
	
	public function getName():String 
	{
		return _name;
	}
	
}