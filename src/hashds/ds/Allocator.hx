package hashds.ds;
import flash.Vector;

/**
 * Fixed counter buffer allocator.
 * @author Glidias
 */

class Allocator<T> implements haxe.rtti.Generic
{
	private var _classe:Class<T>;
	private var _i:Int;
	private var _len:Int;
	private var _vec:Vector<T>;

	/**
	 * 
	 * @param	classe		(Class) A class to instantiate 
	 * @param	fillAmount	(int)	 (Default 0) A value higher than 0 would pre-allocate the allocator with instances
	 * @param   initialCapacity	(int) (Default 0) Initial capacity of Vector buffer.
	 * @param	fillFixed	(Boolean) (Default false) Determines if the Vector buffer will be of fixed length.
	 */
	public function new(classe:Class<T>, fillAmount:Int=0, initialCapacity:Int=0, fixed:Bool=false) 
	{
		_classe = classe;
		_len = 0;
		_i = 0;
		_vec = new Vector<T>(initialCapacity, fixed);
		if (fillAmount > 0) fill(fillAmount, fixed);
	}
	
	inline public function get():T untyped {
		return _i - 1 < _len  ? _vec[_i - 1] : (_vec[_len++] = __new__(_classe()) );
	}
	
	inline public function reset():Void {
		_i = 0;
	}
	inline public function getSize():Int {
		return _len;
	}
	
	public function purge():Void {
		_purge();
	}
	public function purgeAndTruncate(fixed:Bool=false):Void {
		_purge(true, fixed);
	}
	
	inline public function _purge(truncateLength:Bool=false, fixed:Bool=false):Void {
		for (i in _i..._len) {
			_vec[i] = null;
		}
		if (truncateLength) {
			_vec.fixed = false;
			_vec.length = _i;
			_len = _i;
			_vec.fixed = fixed;
		}
	}
	
	public function fill(amount:Int, fixed:Bool):Void {
		_vec.fixed = false;
		_vec.length = amount;
		_len = amount;
		
		while (--amount > -1) {
			if (_vec[amount] == null) _vec[amount] = untyped __new__(_classe);
		}
		_vec.fixed = fixed;
	}
	
	public function setFixed(val:Bool):Void {
		_vec.fixed = val;
	}
	public function getFixed():Bool {
		return _vec.fixed;
	}
		
	public function kill():Void {  
		fill(0, false);
		_i = 0;
	}
	
}