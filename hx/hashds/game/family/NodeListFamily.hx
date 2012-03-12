package hashds.game.family;

import hashds.game.NodeList;
import hashds.game.NodePool;
import hashds.game.Entity;
import hashds.game.Family;
import hashds.game.Node;

/**
 * 
 * @author Glidias
 */

class NodeListFamily extends Family
{
	public var list:NodeList;
	public var pool:NodePool;

	public function new(C:Class<Node>, typeMasking:Int=0) 
	{
		super(this, typeMasking);
		
		list = new NodeList();
		pool = new NodePool(C);

		_reflectClass(C);
	}
	
	public function toString():String {
		return "<NodeListFamily:" + pool.getClass()+">";
	}
	
	override public function add(ent:Entity):Dynamic {
		var node : Node = pool.get();
		injectIntoNode(node, ent);
		list.add( node );
		return node;
	}
	
	
	
	override public function getDataStructure():Dynamic {
		return list;
	}
	

	override public function removeNodeByKey(keyer:Dynamic):Void {
		
		var key:Node = keyer;
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
			var node:Node = list.head;
			while(node!=null)
			{
				_remove(node.entity);
				node = node.next;
			}
			list.removeAll();
		}	
}