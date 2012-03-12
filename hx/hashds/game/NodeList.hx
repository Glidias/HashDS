package hashds.game;
import hashds.signals.Signal1;

/**
 * The default NodeList implementation for Ash, by RichardLord, ported over to Haxe/HashDS for dynamic (non-strict) typing. 
 * 
 * @author Glidias
 */

class NodeList
{
	public var head:Node;
	public var tail:Node;
	
	public var nodeAdded:Signal1<Node>;
	public var nodeRemoved:Signal1<Node>;

	public function new() 
	{
		nodeAdded = new Signal1<Node>();
		nodeRemoved = new Signal1<Node>();
	}
	

	public function add( node : Node ) : Void
	{
		// we assume node is fresh and not part of any list
		if(  head!=null )
		{
			_append(node);
		}
		else
		{
			head = node;
			tail = node;
		}
		
		nodeAdded.dispatch(node);
	}
	
	
	inline public function _append(node:Node):Void {
		tail.next = node;
		node.prev = tail;
		tail = node;
	}
	



	/**
	 * Removes a node from this list, assuming it actually belongs to this list.
	 * @param	node
	 */
	public function remove( node : Node ) : Void
	{
		if ( head == node) head = head.next;
		if ( tail == node) tail = tail.prev;
	
		if (node.prev != null) node.prev.next = node.next;
		if (node.next != null) node.next.prev = node.prev;
		
		nodeRemoved.dispatch(node);
	}
		

	public function removeAll() : Void
	{
		while( head!=null )
		{
			var node : Node = head;
			head = node.next;
			node.prev = null;
			node.next = null;
			nodeRemoved.dispatch(node);
		}
		tail = null;
	}
	
	/**
	 * In most cases, using this method would be fine to quickly null references, hopefully without memory leak.
	 */
	inline public function quickClear():Void {
		head = null;
		tail = null;
	}
	

		public function swap( node1 : Node, node2 : Node ) : Void
		{
			if( node1.prev == node2 )
			{
				node1.prev = node2.prev;
				node2.prev = node1;
				node2.next = node1.next;
				node1.next  = node2;
			}
			else if( node2.prev == node1 )
			{
				node2.prev = node1.prev;
				node1.prev = node2;
				node1.next = node2.next;
				node2.next  = node1;
			}
			else
			{
				var temp : Node = node1.prev;
				node1.prev = node2.prev;
				node2.prev = temp;
				temp = node1.next;
				node1.next = node2.next;
				node2.next = temp;
			}
			if( head == node1 )
			{
				head = node2;
			}
			else if( head == node2 )
			{
				head = node1;
			}
			if( tail == node1 )
			{
				tail = node2;
			}
			else if( tail == node2 )
			{
				tail = node1;
			}
			if( node1.prev!=null )
			{							
				node1.prev.next = node1;
			}
			if( node2.prev!=null )
			{
				node2.prev.next = node2;
			}
			if( node1.next!=null )
			{
				node1.next.prev = node1;
			}
			if( node2.next!=null )
			{
				node2.next.prev = node2;
			}
		}
	
	
}