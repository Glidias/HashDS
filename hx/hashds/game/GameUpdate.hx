package hashds.game;
import hashds.signals.Signal0;

/**
 * Stores game update state and signals
 * @author Glidias
 */

class GameUpdate
{
	public var isUpdating:Bool;
	public var updateComplete:Signal0;


	public function new() 
	{
		isUpdating = false;
		updateComplete = new Signal0();
	}
	
}