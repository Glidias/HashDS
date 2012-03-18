package hashds.game;
import flash.errors.Error;
import hashds.game.factory.PoolEntityFactory;
import hashds.input.KeyPoll;
import hashds.signals.Signal0;
import hashds.signals.Signal1;
import hashds.signals.Signal1;
import hashds.signals.Signal2;
import hashds.signals.Signal3;
import hashds.signals.SignalAny;


#if includeComponents1D
import hashds.components.common.oneD.Age;
import hashds.components.common.oneD.Alpha;
import hashds.components.common.oneD.Rotation;
import hashds.components.common.oneD.Size;
#end
#if includeComponents2D
import hashds.components.common.twoD.Position2;
import hashds.components.common.twoD.Rotation2;
import hashds.components.common.twoD.Scale2;
import hashds.components.common.twoD.Size2;
import hashds.components.common.twoD.Tuple2;
#end
#if includeComponents3D
import hashds.components.common.threeD.Position3;
import hashds.components.common.threeD.Rotation3;
import hashds.components.common.threeD.Scale3;
import hashds.components.common.threeD.Size3;
import hashds.components.common.threeD.Tuple3;
#end

import hashds.game.alchemy.HashDSAlchemy;
import hashds.game.alchemy.ComponentLookup;
import hashds.game.alchemy.nodes.A_DisplayNode;
import hashds.game.alchemy.nodes.A_MovementNode;
import haxe.rtti.Meta;

/**
 * Game framework main class header of core dependencies
 * @author Glidias
 */

class HashDSGame 
{
	static function main():Void {
		
		// HashDS Game 
		Game;
		ComponentID;
		
		//HashDS Signals
		Signal0;
		Signal1;
		Signal2;
		Signal3;
		SignalAny;
		
		// Factories
		PoolEntityFactory;	
		
		// KeyPoll
		KeyPoll;
		
		//Alchemy Branch of HashDS Game
		HashDSAlchemy;
		
	//	throw new Error( new A_DisplayNode().getBlockSize() );
		
		///*
		
	
	}
	
	public function new() 
	{
		
	}
	
}