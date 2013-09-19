SumChildren
===========

This is a demo OS X Core Data app that works.  Originally it two issues in updating
dependent attributes.  See https://devforums.apple.com/message/892973#892973

The project has two entities in a parent/child relationship…
 
- Parent and child data are presented in separate table views.
- The child object has 3 decimal type attributes: childOne, childTwo, childThree
- The parent has one decimal type attribute, parentSum

The thing to learn from this project is the use of "business logic" code
to satisfy the following requirments, which did not work originally.
(The first requirement *looked* like it was working, but in fact model changes
were not being saved to the store.)

- In each child, childThree = childOne * childTwo
- In each parent, parentSum = the sum of all its children's childThree.

In the first case, we solve the problem by using custom setters in the
implementation of Child.  In the second case, we use Key Value Observing (KVO)
in the implementation of Parent.  Both strategies work, although KVO is easier
for observing to-many relationships.

Oh, it would have taken much less code to implement the derived properties
childThree and parentSum simply as methods which calculate them when needed,
and not store them in the store.  However the project's author made it a
requirement that they be in the store.  This is sometimes necessary for
performance reasons.

This is a good illustration of how it is deceptively simple to write a simple
Core Data app such as Apple's examples, but as soon as you start to throw
in real-world requirements in a real app, the lines of code start to pile up
quickly.  I still use Core Data, though, because it's not so hard once you've
done it a few times, and I would rather write business logic than the Undo and
Redo code which Core Data does quite nicely for you.

One more thing.  Writing the business logic for this project was kind of painful
and error-prone due to the lack of accessors.  One way to get accessors in a 
real Core Data project is to use mogenerator:

https://github.com/rentzsch/mogenerator

The next thing I notice is that when you're running this project and create some
entities, then quit and relqunch, the entities are displayed in a different,
arbitrary order.  That's a whole 'nother can of worms :)