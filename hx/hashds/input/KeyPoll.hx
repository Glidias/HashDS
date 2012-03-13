/*
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2007
 * Version: 1.0.2
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package hashds.input;
	#if (usePolygonal || usePolygonalKey)
	import de.polygonal.ds.mem.ByteMemory;
	#end
	
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * <p>Games often need to get the current state of various keys in order to respond to user input. 
	 * This is not the same as responding to key down and key up events, but is rather a case of discovering 
	 * if a particular key is currently pressed.</p>
	 * 
	 * <p>In Actionscript 2 this was a simple matter of calling Key.isDown() with the appropriate key code. 
	 * But in Actionscript 3 Key.isDown no longer exists and the only intrinsic way to react to the keyboard 
	 * is via the keyUp and keyDown events.</p>
	 * 
	 * <p>The KeyPoll class rectifies this. It has isDown and isUp methods, each taking a key code as a 
	 * parameter and returning a Boolean.</p>
	 */
	/**
	 * Integration with Polygonal DS (alchemy)
	 * @author Glenn
	 */
	class KeyPoll
	{
		#if (usePolygonal || usePolygonalKey)
		private var states:ByteMemory;
		#else
		private var states:ByteArray;
		#end
		
		private var dispObj:IEventDispatcher;

		
		/**
		 * Constructor
		 * 
		 * @param displayObj a display object on which to test listen for keyboard events. To catch all key events use the stage.
		 */
		public function new( displayObj:IEventDispatcher )
		{
			#if (usePolygonal || usePolygonalKey)
			states = new ByteMemory(32, "KeyPoll");
			#else
			states = new ByteArray();
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			#end
			
			dispObj = displayObj;
			dispObj.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true );
			dispObj.addEventListener( KeyboardEvent.KEY_UP, keyUpListener, false, 0, true );
			dispObj.addEventListener( Event.ACTIVATE, clearListener, false, 0, true );
			dispObj.addEventListener( Event.DEACTIVATE, clearListener, false, 0, true );
	
		}
		
		public function destroy():Void {
			dispObj.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			dispObj.removeEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			dispObj.removeEventListener( Event.ACTIVATE, clearListener );
			dispObj.removeEventListener( Event.DEACTIVATE, clearListener );
			#if (usePolygonal || usePolygonalKey)
			states.free();
			#end
		}
		
		private function keyDownListener( ev:KeyboardEvent ):Void
		{
			#if (usePolygonal || usePolygonalKey)
		
			states.set(  (ev.keyCode >>> 3),  states.get(ev.keyCode >>> 3) | (1<<(ev.keyCode & 7))  );
			#else
			states[ ev.keyCode >>> 3 ] |= 1 << (ev.keyCode & 7);
			#end
		}
		
		private function keyUpListener( ev:KeyboardEvent ):Void
		{
			#if (usePolygonal || usePolygonalKey)
			states.set(  (ev.keyCode >>> 3),  states.get(ev.keyCode >>> 3) & (~(1<<(ev.keyCode & 7))) );
			#else
			states[ ev.keyCode >>> 3 ] &= ~(1 << (ev.keyCode & 7));
			#end
		}
		
		private function clearListener( ev:Event ):Void
		{
			#if (usePolygonal || usePolygonalKey)
			var i:Int = 0;
			while (++i < 8) {
				states.set(i, 0);
			}
			#else
			var i:Int = 0;
			while (++i < 8) {
				states[ i ] = 0;
			}
			#end
		}
		
		/**
		 * To test whether a key is down.
		 *
		 * @param keyCode code for the key to test.
		 *
		 * @return true if the key is down, false otherwise.
		 *
		 * @see isUp
		 */
		public inline function isDown( keyCode:UInt ):Bool
		{
			#if (usePolygonal || usePolygonalKey)
			return (states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) != 0;
			#else
			return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) != 0;
			#end
		}
		
		/**
		 * To test whetrher a key is up.
		 *
		 * @param keyCode code for the key to test.
		 *
		 * @return true if the key is up, false otherwise.
		 *
		 * @see isDown
		 */
		public inline function isUp( keyCode:UInt ):Bool
		{
			#if (usePolygonal || usePolygonalKey)
			return (states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) == 0;
			#else
			return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) == 0;
			#end
		}
	
}