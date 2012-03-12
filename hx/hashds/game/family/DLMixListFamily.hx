package hashds.game.family;

import flash.errors.Error;
import hashds.ds.DLMixPool;
import hashds.ds.Indexable;
import hashds.game.Family;
import hashds.ds.DLMixList;
import hashds.ds.IDLMixNode;
import hashds.game.IEntityMarker;
import haxe.rtti.Generic;


/**
 * Family that uses DLMixList, the strictly-typed generic version of NodeList.
 * @author Glidias
 */

class DLMixListFamily<T:(IDLMixNode<T>, IEntityMarker #if (!entityOwns && usePolygonal), Indexable #end) > extends Family, implements Generic
{
	public var list:DLMixList<T>;
	public var pool:DLMixPool<T>;
	
	public function new(C:Class<T>, typeMasking:Int=0) 
	{
		super(this, typeMasking);
		list = new DLMixList<T>();
		pool = new DLMixPool<T>(C);
		
		_reflectClass(C);
	}
	
	public function toString():String {
		return "<DLMixListFamily:" + pool.getClass()+">";
	}
	
	override public function add(ent:Entity):Dynamic {
		var node : T = pool.get();
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
		
		if( _gameUpdate.isUpdating )
		{
			pool.cache(key );
			_gameUpdate.updateComplete.add( releaseNodePoolCache );  // <- repeated hash checks here, but not much choice
		}
		else
		{
			pool.dispose( key);
		}
		
	}

		
		private function releaseNodePoolCache() : Void
		{
			_gameUpdate.updateComplete.remove( releaseNodePoolCache );
			pool.releaseCache();
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