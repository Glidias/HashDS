package hashds.signals;
import flash.utils.Dictionary;
import hashds.ds.DLMixPool;
import haxe.rtti.Generic;

/**
 * ...
 * @author Glidias
 */

class Signal1<T> implements Generic
{

	public function new() 
	{
		init();
	}
	
	public function dispatch( param1 : T ) : Void
	{
		startDispatch();
		var node : ListenerNode1 = head;
		while ( node!=null )
		{
			node.listener(param1);
			node = node.next;
		}
		endDispatch();
	}
	
	// Boilerplate
	
	private var head : ListenerNode1;
	private var tail : ListenerNode1;
	private var nodes : Dictionary;
	private var listenerNodePool:DLMixPool<ListenerNode1>;
	private var toAddHead:ListenerNode1;
	private var toAddTail:ListenerNode1;
	private var dispatching:Bool;
	
	private function init():Void {
		nodes = new Dictionary( true );
		listenerNodePool = new DLMixPool<ListenerNode1>(ListenerNode1);
	}
	
	private  inline function startDispatch() : Void
		{
			dispatching = true;
		}
		
		private inline function endDispatch() : Void
		{
			dispatching = false;
			if( toAddHead!=null )
			{
				if( head == null )
				{
					head = toAddHead;
					tail = toAddTail;
				}
				else
				{
					tail.next = toAddHead;
					toAddHead.prev = tail;
					tail = toAddTail;
				}
				toAddHead = null;
				toAddTail = null;
			}
			listenerNodePool.releaseCache();
		}

		public function add( listener :Dynamic  ) : Void
		{
			if( untyped nodes[ listener ] )
			{
				return;
			}
			var node : ListenerNode1 = listenerNodePool.get();
			node.listener = listener;
			untyped nodes[ listener ] = node;
			if( dispatching )
			{
				if( toAddHead==null )
				{
					toAddHead = toAddTail = node;
				}
				else
				{
					toAddTail.next = node;
					node.prev = toAddTail;
					toAddTail = node;
				}
			}
			else
			{
				if ( head == null )
				{
					head = tail = node;
				}
				else
				{
					tail.next = node;
					node.prev = tail;
					tail = node;
				}
			}
		}

		public function remove( listener : Dynamic ) : Void
		{
			var node : ListenerNode1 = untyped nodes[ listener ];
			if ( node!=null )
			{
				if ( head == node)
				{
					head = head.next;
				}
				if ( tail == node)
				{
					tail = tail.prev;
				}
				if ( toAddHead == node)
				{
					toAddHead = toAddHead.next;
				}
				if ( toAddTail == node)
				{
					toAddTail = toAddTail.prev;
				}
				if (node.prev!=null)
				{
					node.prev.next = node.next;
				}
				if (node.next!=null)
				{
					node.next.prev = node.prev;
				}
				untyped __delete__(nodes, listener);
				if( dispatching )
				{
					listenerNodePool.cache( node );
				}
				else
				{
					listenerNodePool.dispose( node );
				}
			}
		}
		
		
		public function removeAll() : Void
		{
			while( head !=null)
			{
				var listener : ListenerNode1 = head;
				head = head.next;
				listener.prev = null;
				listener.next = null;
			}
			tail = null;
			toAddHead = null;
			toAddTail = null;
		}
	
}