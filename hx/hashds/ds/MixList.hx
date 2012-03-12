package hashds.ds;

/**
 * A singly-linked link list header generic implementation. Simple as it can get. Only allows prepending.
 * 
 * If you're iterating through a list that involves no removal or alteration of structure during iteration, using this can be an alternative compared
 * to DLMixList. However, removal of nodes has a linear O(n) cost.
 * 
 * A possible way to avoid this is to have the system's node data of such a list to contain a "dead" flag and a
 * sole system is responsible for removing those nodes if found to be dead during it's loop.
 * 
 * @see hashds.ds.IDead
 * @see hashds.ds.ISLMixNode
 * @see hashds.ds.DLMixList
 * 
 * @author Glidias
 */

class MixList<T:ISLMixNode<T>> implements haxe.rtti.Generic 
{
	public var head:T;

	public function new() 
	{
		
	}

	inline public function add( node : T ) : Void
	{
		node.next = head;
		head = node;
	}
	

	public function remove( node : T ) : Bool
	{
		var prev:T;
		var n:T = node;
	
		if (n == head) {
			head = node.next;
			//n.next = null; 
			return true;
		}
		prev = n;
		n = n.next;

		while (n != null) {
			if (n== node) {
				
				break;
			}
			prev = n;
			n = n.next;
		}
		if (n == null) return false;
		
		prev.next = n.next;
		//n.next = null; 
		return true;
	}
		

	/**
	 * Unlink all links for full clean-up
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