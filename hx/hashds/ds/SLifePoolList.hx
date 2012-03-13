package hashds.ds;

/**
 * A singly-linked link list with pool built-in.
 * 
 * Has a dead marker for each node to mark dead entities, but this requires another 
 * system to check through such a list in order to return it manually to pool if found dead.
 * 
 * @see hashds.ds.IDead
 * @see hashds.ds.ISLMixNode
 * @see hashds.ds.DLMixList
 * 
 * @author Glidias
 */

class SLifePoolList<T:(ISLMixNode<T>,IDead)> implements haxe.rtti.Generic 
{
	public var head:T;
	public var pool:MixPool<T>;

	public function new(C:Class<T>) 
	{
		pool = new hashds.ds.MixPool<T>(C);
	}

	inline public function add( node : T ) : Void
	{
		node.next = head;
		node.dead = false;
		head = node;
	}

	inline public function remove( node : T ) : Void
	{

		node.dead = true;
	}
	
	
	inline public function returnToPool(node:T):Void {
		pool.putBack(node);
	}
	
	/**
	 * Unlink all links for full clean-up returning to pool
	 */
	public function removeAllToPool():Void {
		while( head!=null )
		{
			var node : T = head;
			head = node.next;
			pool.putBack(node);
		}
	}
		

	/**
	 * Unlink all links for full clean-up without returning to pool
	 */
	public function removeAll() : Void
	{
		while( head!=null )
		{
			var node : T = head;
			head = node.next;
			node.next = null;
		}
	}
	
	/**
	 * In most cases, using this method would be fine to quickly null references, hopefully without memory leak.
	 */
	inline public function quickClear():Void {
		head = null;
	}
	
}