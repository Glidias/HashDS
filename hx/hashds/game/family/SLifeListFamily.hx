package hashds.game.family;

import hashds.ds.DLMixPool;
import hashds.ds.Indexable;
import hashds.game.Family;
import hashds.ds.DLMixList;
import hashds.ds.IDLMixNode;
import hashds.game.IEntityMarker;
import hashds.ds.SLifePoolList;
import hashds.ds.ISLMixNode;
import hashds.ds.IDead;
import hashds.game.nodes.SLEntLifeNode;
import haxe.rtti.Generic;


/**
 *  Family that uses SLifePoolList.
 * @author Glidias
 */

class SLifeListFamily<T:(ISLMixNode<T>, IDead, IEntityMarker #if (!entityOwns && usePolygonal), Indexable #end) > extends Family, implements Generic
{
	public var list:SLifePoolList<T>;

	
	public function new(C:Class<T>, typeMasking:Int=0) 
	{
		super(this, typeMasking);
		list = new SLifePoolList<T>(C);
		
		_reflectClass(C);
	}
	
	public function toString():String {
		return "<SLifeListFamily:" + list.pool.getClass()+">";
	}
	
	override public function add(ent:Entity):Dynamic {
		var node : T = list.pool.get();
		injectIntoNode(node, ent);
		list.add( node );
		return node;
	}
	
	
	override public function getDataStructure():Dynamic {
		return list;
	}
	
	override public function removeNodeByKey(keyer:Dynamic):Void {
		var key:T  =  keyer;
		list.remove( key );
	}	
	
	override public function cleanup() : Void
	{
		var node:T = list.head;
		while(node!=null)
		{
			_remove(node.entity);
			node = node.next;
		}
		list.removeAll();
	}	
	
}