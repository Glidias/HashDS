package hashds.game.alchemy;

/**
 * Open-ended interface implementation for component data structures
 * @author Glenn Ko
 */

interface IComponentDS 
{

	function _free(key:Int):Void;
	function getId():Int;
	function getName():String;
	
}