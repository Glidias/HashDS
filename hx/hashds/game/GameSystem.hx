package hashds.game;
import hashds.ds.IDLMixNode;
import hashds.ds.IPrioritizable;

/**
 * ...
 * @author Glidias
 */

class GameSystem implements IDLMixNode<GameSystem>, implements IPrioritizable
{
	public var next:GameSystem;
	public var prev:GameSystem;

	public function new() 
	{
		priority = 0;
	}
	

		/**
		 * Used internally to hold the priority of this system within a system list. This is 
		 * used to order the systems so they are updated in the correct order.
		 */
		public var priority : Int;
		

		
		/**
		 * Called just after the system is added to the game, before any calls to the update method.
		 * Override this method to add your own functionality.
		 * 
		 * @param game The game the system was added to.
		 */
		public function addToGame( game : Game ) : Void
		{
			
		}
		
		/**
		 * Called just after the system is removed from the game, after all calls to the update method.
		 * Override this method to add your own functionality.
		 * 
		 * @param game The game the system was removed from.
		 */
		public function removeFromGame( game : Game ) : Void
		{
			
		}
		
		/**
		 * After the system is added to the game, this method is called every frame until the system
		 * is removed from the game. Override this method to add your own functionality.
		 * 
		 * <p>If you need to perform an action outside of the update loop (e.g. you need to change the
		 * systems in the game and you don't want to do it while they're updating) add a listener to
		 * the game's updateComplete signal to be notified when the update loop completes.</p>
		 * 
		 * @param time The duration, in seconds, of the frame.
		 */
		public function update( dt : Float ) : Void
		{
			
		}
	
}