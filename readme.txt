HashDS is a Haxe port and modification of the Ash framework which uses an entity-component/data-oriented approach to game development instead of object oriented paradigms. 

The Haxe port typically provides more options for strict typing, conditional compiling (to modify the default library build), optimization, inlining, among some other things. You can use this library in pure As3/Flash environment by using the available SWC builds (note: yet to be released), or create a modifiable swc build of your own with Haxe to support strictly typed components, data structures, etc. to use in Flash/As3. Alternatively, you can write your game entirely in Haxe with the Haxe code-base working closely alongside you. 

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

- Additional 32bit int type masking discriminant for Family and Entity instances, to ensure entities get registered to specific families without relying on empty dummy components and dummy node fields. 

- Register such families directly to the game at runtime.

- Compile strictly typed families and data structures with Generics within Haxe, using the existing 'ds' package, or reate your own families with other data structure approaches.  This allows you to iterate through strictly typed data without the overhead of coercing a Node's generic prev:* and next:* pointers to the given concrete type. Any other data structure type alternative (like singly-linked list) is possible.

- Family now has a setupSecondList(arr:Array):Void method to support adding a secondary choice list of families to run though for exact component matches. For example, if an entity has all 5 components like Object3D, Position, Rotation, Scale , than it may end up getting registered to multiple families that uses Object3D/Position, and also another family like Object3D/Position,  and another family like Object3D/Position/Rotation, etc. To avoid this situation, you can create a an initial family with Object3D/Position,  and than use family.setupSecondList([Array of Possible Alternative Families to CHoose From]), which will attempt to find an exact sub-match if possible, else it'd use the default Object3D/Position family


Entity lifecycle creation/pooling:
----------------------------------

- All entities has a pool pointer to support pooling/disposal of entities.

- Entities should created and initialized by factories, which normally provide a pool implementation (or a dummy pool implementation) and default constructor settings, in situations where pooling isn't required. Some basic factory implementations (like BasicEntityFactory) extending from AbstractEntityFactory are provided, and these can be used directly or composed into your own entity creation factory classes.


Misc changes:
---------------

- No more componentAdded/componentRemoved signal triggers. Systems are now resposible for actively notifying the current game of any component (or type mask) changes made during an entity's lifespan, to reduce the overhead of the Game or families having to actively listen to entities' signals and removing these signals afterwards.


Optional compile parameter options:
-----------------------------------

- component64/component32: for quick bitmask check for whether an entity matches a given family, given it's components. This would however limit total number of components allowed in the game to up to 64/32 components accordingly.

- family64/family32: for quick bitmask check for whether a family contains an entity. THis would however limit the total number of families allowed in the game to up to 64/32 families accordingly.

- usePolygonal: Uses Polygonal's IntHash/IntIntHash data structures instead of Flash's native Dictionary class.

- alchemy: To allow use of alchemy memory access for usePolygonal data structures.

- entityOwns: To store family key nodes directly within entities without having to run through all families in the game to check for removal, or use a hash within each family data structure to lookup nodes.

- fixedGame: This can be used if you plan to set up all families and their related systems beforehand, before adding any entities, and do not intend to change the game configuration at all except for the order of systems. As such, there's no need to maintain a doubly-linked list of entities in the Game itself, so this can be removed from the compiled build with this flag.




