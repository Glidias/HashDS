HashDS is a Haxe port and modification of the Ash framework, both of which uses an entity-component/data-oriented approach to game development instead of object oriented paradigms. 

The Haxe port typically provides more options for strict typing, conditional compiling (to modify the default library build), optimization, inlining, among some other things. You can use this library in pure As3/Flash environment by using the available SWC builds, or create a modifiable swc build of your own with Haxe to support strictly typed components, data structures, etc. to use in Flash/As3. Alternatively, you can write your game entirely in Haxe with the Haxe code-base working closely alongside you. 

In the future, I might want to support non-Flash targets like JS (which should be relatively easy to do so..actually, but I doubt I would). So, you're free to fork the library and use it accordingly, maybe do a JS port for those that are interested. After all, the core of the library is just data structures and logic, which should be easily swappable to different target platforms in most situations.

Currently, all the intended features of HashDS has been created already. They just need to undergo testing, as there can be different types of compiled build options available. So, use this library at your own risk. Also take note that even though it's a port (in a loose sense) of the Ash framework, the API is noticably different from Ash.

Without further ado, here are the full list of features that differentiates HashDS from Ash.



Signals:
----------------------------------
- Ash's signals package, which is ported over to Haxe/HashDS to support Generic strictly-typed parameters.


Families and data structures
-----------------------------
- Data structure 'ds' package of Generic classes within the library, which can be used standalone without the 'game' package.

- Family is now an abstract base class, which can be extended to support your own custom data structures. 

- The default on-the-fly dynamic family implementation that was used in Ash is now found in family.NodeListFamily (under the game package), which handles the NodeList and Node respectively.

- Additional 32bit int type masking discriminant for Family and Entity instances, to ensure entities get registered to specific families without relying on empty dummy components and dummy node fields. 

- Register such families directly to the game at runtime.

- Compile strictly typed families and data structures with Generics within Haxe, using the existing 'ds' package, or create your own families with other data structure approaches.  This allows you to iterate through strictly typed data without the overhead of coercing a Node's generic prev:* and next:* pointers to the given concrete type. Any other data structure type alternative (like singly-linked list) is possible.

- Family now has a setupSecondList(arr:Array):Void method to support adding a secondary choice list of families to attempt to get a secondary exact component match. For example, if an entity has all the components like Object3D+Position+Rotation+Scale , than it may end up getting registered to multiple families that may use Object3D+Position, and also another family that uses Object3D+Position+Rotation,  besides the intended family that uses Object3D+Position+Rotation+Scale. To avoid this situation, you can create a an initial family with Object3D+Position,  and than use family.setupSecondList([Array of Possible Alternative Families to CHoose From]), which will attempt to find the best sub-match if possible, else it'd use the default Object3D+Position family.


Entity lifecycle creation/pooling:
----------------------------------

- All entities has a pool pointer to support pooling/disposal of entities.

- Entities should created and initialized by factories, which normally provide a pool implementation (or a dummy pool implementation) and default constructor settings, in situations where pooling isn't required. Some basic factory implementations (like BasicEntityFactory) extending from AbstractEntityFactory are provided, and these can be used directly or composed into your own game-specific entity creation factory classes.


Component changes:
---------------

- No more componentAdded/componentRemoved signal triggers. Systems are now resposible for actively notifying the current game of any component (or type mask) changes made during an entity's lifespan, to reduce the overhead of the Game or families having to actively listen to entities' signals and removing these signals afterwards. However, without a per-family observer approach, there might possibly be an additional overhead having to handle live entity component state changes across the entire game system from the top-down.

- Component classes are recognised by a public static var ID:Int counter. These should not be changed but initialized once using ComponentID.next(). The integer ID is used as a key for hashing.

Optional compile parameter options:
-----------------------------------

- component64/component32: for quick bitmask check for whether an entity matches a given family, given it's components. This would however limit total number of components allowed in the game to up to 64/32 components accordingly.

- family64/family32: for quick bitmask check for whether a family contains an entity. THis would however limit the total number of families allowed in the game to up to 64/32 families accordingly.

- usePolygonal: Uses Polygonal's IntHash/IntIntHash data structures instead of Flash's native Dictionary class.

- alchemy: To allow use of alchemy memory access for usePolygonal data structures.

- entityOwns: To store family key nodes directly within entities without having to run through all families in the game to check for removal. Using this means that no hashes are required in the Family base class, but potentially there may be higher memory usage since each entity will store it's own family key list.

- fixedGame: This can be used if you plan to register all families and their related systems beforehand, before adding any entities, and do not intend to change the game configuration at all except for the running order/availability of systems. As such, there's no need to maintain a doubly-linked list of entities in the Game itself, so the global entities list gets removed from the compiled build with this flag turned on. 



Pure Alchemy/Haxe branch:
-------------------------
Currently a WIP under hashds.game.alchemy, the alchemy branch of HashDS allows for a completely data-oriented game, allowing true parallization capability of homogenous data within your game. The rationale behind the Alchemy branch lies in the fact that since all components and nodes are of a similar type and have the same set of variables, why have multiple instances of these instances per entity floating everywhere in memory? Why not just use 1 data-structure for each component, and 1 data structure for each node, and have them arranged in contiguous set within memory running in parallel within the game system? 

Here's what makes it different:
	
- No Entity class. Game stores a vector array of fast IntIntHashTables to relate a set of components to an entity. An entity is simply identified by it's index position within the vector array.

-  A component is now a data structure itself. They are registered first before any families/factories are registered. They can be given a unique name, to avoid the boilerplate of dupicating/extending dummy classes. Components that consist purely of numeric data oftne uses ALchemy memory as a data structure, allowing systems to crunch numbers real fast.

- Component instancse contains helper inline methods to perform operations directly on addresses within alchemy Memory, whether it be accessing a certain component data or setting up the component itself. This makes it fairly easy to retrieve values in/out of a component.

- Component instances are meta-data injected into factories to facilitate adding components speedily into an entity.

- A node also acts a data structure itself, functioning purely in Alchemy memory with address integers pointing directly to the component addresses for each entity. 
Additional getter/setter fields specific to a node can be added as well if a system needs it.

- Component instances are meta-data injected into system nodes to facilitiate getting component data required for the given node. This is done for the convenience of systems and reflection.

- All components that function under Alchemy memory and nodes can reflect their block-size in bytes automatically under a base class, based on the fields marked with meta-data. This makes it easy to create new component/node data structures that run purely under Alchemy memory.
