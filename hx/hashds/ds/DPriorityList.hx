package hashds.ds;

/**
 * A double linked list whose node contain a data pointer.  Traditional node-based doubly-linked list with priority sorting.
 * @author Glidias
 */

class DPriorityList<T:IPrioritizable>
{

	public var head:DPriorityNode<T>;
	public var tail:DPriorityNode<T>;
	
	public function new() 
	{
		
	}
	
	public function add(data:T):Void {
		var toAddNode = new DPriorityNode<T>();
		toAddNode.data = data;
		
		var node:DPriorityNode<T>;
		
		if(  head == null )
		{
			head = tail = toAddNode;
		}
		else
		{
			node = tail;
			while( node!=null  )
			{
				if( node.data.priority <= data.priority )
				{
					break;
				}
				node = node.prev;
			}
			if( node == tail )
			{
				tail.next = toAddNode;
				toAddNode.prev = tail;
				tail = toAddNode;
			}
			else if( node == null )
			{
				toAddNode.next = head;
				head.prev = toAddNode;
				head = toAddNode;
			}
			else
			{
				toAddNode.next = node.next;
				toAddNode.prev = node;
				node.next.prev = toAddNode;
				node.next = toAddNode;
			}
		}
	}
	
	public function findNodeByData(data:T):DPriorityNode<T> {
		var node = head;
		while (node != null) {
			if (node.data == data) return node;
			node = node.next;
		}
		return null;
	}
	
	
	
		///*
		public function remove( data : T ) : Void
		{
			var toRemoveNode = findNodeByData(data);
			if ( head == toRemoveNode)
			{
				head = head.next;
			}
			if ( tail == toRemoveNode)
			{
				tail = tail.prev;
			}
			
			if (toRemoveNode.prev!=null)
			{
				toRemoveNode.prev.next = toRemoveNode.next;
			}
			
			if (toRemoveNode.next!=null)
			{
				toRemoveNode.next.prev = toRemoveNode.prev;
			}
		}
		
		public function removeAll() : Void
		{
			while( head!=null )
			{
				var node  = head;
				head = head.next;
				node.prev = null;
				node.next = null;
			}
			tail = null;
		}
		
	
}