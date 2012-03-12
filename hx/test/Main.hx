package test;

import examples.asteroids.nodes.DisplayPSANode;
import examples.asteroids.nodes.LifeNode;
import examples.asteroids.nodes.RadialCollisionNode;
import examples.asteroids.systems.DisplaySystem;
import flash.errors.Error;
import flash.Lib;
import flash.utils.Dictionary;
import hashds.components.common.threeD.Position3;
import hashds.components.common.threeD.Rotation3;
import hashds.components.common.threeD.Scale3;
import hashds.components.common.twoD.Position2;
import hashds.ds.Allocator;
import hashds.ds.DLMixList;
import hashds.ds.DLMixPool;
import hashds.ds.DPriorityList;
import hashds.ds.DPriorityNode;
import hashds.ds.MixPool;
import hashds.ds.SLifePoolList;
import hashds.ds.SLifePoolList;
import hashds.ds.SLifePoolList;
import hashds.ds.SLMixList;
import hashds.game.family.SLifeListFamily;
import hashds.game.nodes.DLEntNode;
import hashds.game.nodes.SLEntLifeNode;
import test.PNode;
import test.PRNode;
import test.PRSNode;
import test.PSNode;
import test.TestDLMix;
import test.TestPrioritizable;
import hashds.game.Entity;
import hashds.game.Family;
import hashds.game.family.DLMixListFamily;
import hashds.game.family.NodeListFamily;
import hashds.game.Game;
import hashds.game.Node;
import hashds.signals.Signal0;
import hashds.signals.Signal1;
import hashds.signals.Signal2;
import hashds.signals.Signal3;
import hashds.signals.SignalAny;
import haxe.rtti.Meta;
import hashds.ds.MixList;
import test.TestIndexableItem;
import test.TestSLMix;
import hashds.ds.VectorIndex;
import hashds.hutil.XYZ;
import hashds.hutil.XYZUtils;
import hashds.components.common.threeD.Position3;


/**
 * ...
 * @author Glidias
 */

class Main 
{
	
	static function main() 
	{
		var mixList = new MixList<TestSLMix>();	
	
		var mySL:TestSLMix = new TestSLMix();
		mixList.add(mySL);
		mixList.add(TestSLMix.get(0, 0, 13, 13, 155));
		DisplaySystem;
		var tester:DisplayPSANode = new DisplayPSANode();
		var tester2 = new SLifePoolList<LifeNode>(LifeNode);
		var tester3 = new DLMixList<RadialCollisionNode>();
		var tester4 = new SLifeListFamily<LifeNode>(LifeNode);
		
		var myMixList = new SLMixList<TestSLMix>();
		var testSL:TestSLMix = mixList.head;
		while (testSL != null) {
			var data1:Float = testSL.data1;
			var data2:Float = testSL.data2;
			testSL = testSL.next;
			var dot:Float = XYZUtils.dotProduct3(testSL, mySL); 
			
			// continue
			testSL = testSL.next; 
		}
		
		var buffer:VectorIndex<TestIndexableItem> = new VectorIndex<TestIndexableItem>();
		buffer.push(new TestIndexableItem() );
		buffer.push(new TestIndexableItem() );
		
		
		var ent:Entity = Entity.get();
		ent.addComponent( Position3.get(0, 0, 0) );
		ent.addComponent( Rotation3.get(0, 0, 0) );
		ent.addComponent( Scale3.get(0, 0, 0) );
		
		Position2;
		
		
		//var dynSignal = new Signal1<Unknown<0>>();
		var myDL:TestDLMix = new TestDLMix();
		var mixDList = new DLMixList<TestDLMix>();
		mixDList.add(myDL);
		
		var dlPool = new DLMixPool<TestDLMix>(TestDLMix);
		
		var vecIndex:VectorIndex<TestIndexableItem> = new VectorIndex<TestIndexableItem>();
	
		var myMixPool = new MixPool<TestSLMix>(TestSLMix);
		
		var allocator = new Allocator<TestSLMix>(TestSLMix);
		

		var signalsANy:SignalAny;
		var signal0:Signal0;
		var signal1:Signal1<Int>;
		var signal2:Signal2<Float,Int>;
		var signal3:Signal3<Float,Float,Int>;
		
		var dict:Dictionary = new Dictionary();
		
		var well:Dynamic = new DLMixList<TestDLMix>();
		untyped dict[TestDLMix] = well;
		
		var coerce:DLMixList<TestDLMix> = untyped dict[TestDLMix];
		
		var priorityList = new DPriorityList<TestPrioritizable>();
		var priorityNode = new DPriorityNode<TestPrioritizable>();
		
		

		var fam2 = new NodeListFamily(PNode);// new NodeListFamily();
		var fam = new DLMixListFamily<TestDLMix>(TestDLMix);
		
		var renderFamily = new NodeListFamily(PNode);
		renderFamily.setupSecondList(
		[
			new NodeListFamily(PRNode),
			new NodeListFamily(PRSNode),
			new NodeListFamily(PSNode)
		]
		);
		
		
	}
	
	
	
}