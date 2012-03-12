package hashds.game;
import flash.errors.Error;

/**
 * Component ID static counter to uniquely identify components. All concrete component classes need to have a static public var/const field
 * called "ID" to store an integer key using this counter. This would uniquely identify component classes used in the HashDS framework. 
 * @author Glidias
 */

class ComponentID
{
	static var _counter = 0;
	
	/**
	 * Returns the next integer in a list of unique, unsigned integer keys. 
	 */
	#if (!component32 && !component64) inline #end
	public static function next():Int
	{
		#if (component32 || component64)
			#if component64
			if (_counter + 1 >= 64) throw new Error("64 bit component limit exceeded!");
			#else
			if (_counter + 1 >= 32) throw new Error("32 bit component limit exceeded!");
			#end
		#end
		return _counter++;
	}
}