package hashds.ds;
/**
 * A very simple minimal singly-linked node pool
 * @author Glidias
 */

class MixPool<T:ISLMixNode<T>> implements haxe.rtti.Generic
{
	private var _pool:T;
	private var _C:Class<T>;
	inline public function getClass():Class<T> {
		return _C;
	}

	public function new(C:Class<T>) 
	{
		_C = C;
	}
	
	inline public function putBack(item:T):Void {
		item.next = _pool;
		_pool = item;
	}
	
	inline public function get():T  {
		var instance:T = _pool != null ? _pool : untyped __new__(_C);
		_pool = instance.next;
		return instance;
	}
	
}