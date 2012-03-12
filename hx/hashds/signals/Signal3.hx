package hashds.signals;
import haxe.rtti.Generic;
import flash.utils.Dictionary;
import hashds.ds.DLMixPool;

/**
 * ...
 * @author Glidias
 */

class Signal3<T,U,V> implements Generic
{

	public function new() 
	{
		init();
	}
	
	public function dispatch( param1:T, param2:U, param3:V ) : Void
	{
		startDispatch();
		var node : ListenerNode3 = head;
		while ( node!=null )
		{
			node.listener(param1, param2, param3);
			node = node.next;
		}
		endDispatch();
	}
	
	// Boilerplate
	
	private var head : ListenerNode3;
	private var tail : ListenerNode3;
	private var nodes : Dictionary;
	private var listenerNodePool:DLMixPool<ListenerNode3>;
	private var toAddHead:ListenerNode3;
	private var toAddTail:ListenerNode3;
	private var dispatching:Bool;
	
	private function init():Void {
		nodes = new Dictionary( true );
		listenerNodePool = new DLMixPool<ListenerNode3>(ListenerNode3);
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

		public function add( listener :Dynamic -> Dynamic -> Dynamic ->Void  ) : Void
		{
			if( untyped nodes[ listener ] )
			{
				return;
			}
			var node : ListenerNode3 = listenerNodePool.get();
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

		public function remove( listener : Dynamic -> Dynamic -> Dynamic ->Void  ) : Void
		{
			var node : ListenerNode3 = untyped nodes[ listener ];
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
				var listener : ListenerNode3 = head;
				head = head.next;
				listener.prev = null;
				listener.next = null;
			}
			tail = null;
			toAddHead = null;
			toAddTail = null;
		}
	
}