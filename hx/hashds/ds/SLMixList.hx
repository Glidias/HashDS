package hashds.ds;
import hashds.signals.Signal1;

/**
 * 
 * MixList that contains signal notifications.
 * 
 * 
 * @see hashds.ds.ISLMixNode
 * @author Glidias
 */

class SLMixList<T:ISLMixNode<T>> implements haxe.rtti.Generic 
{
	public var head:T;
	
	public var nodeAdded:Signal1<T>;
	public var nodeRemoved:Signal1<T>;

	public function new() 
	{
		nodeAdded = new Signal1<T>();
		nodeRemoved = new Signal1<T>();
	}

	inline public function add( node : T ) : Void
	{
		node.next = head;
		head = node;
		nodeAdded.dispatch(node);
	}


	public function remove( node : T ) : Bool
	{
		var prev:T;
		var n:T = node;
	
		if (n == head) {
			head = node.next;
			n.next = null;
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
		nodeRemoved.dispatch(node); 
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
			nodeRemoved.dispatch(node);
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