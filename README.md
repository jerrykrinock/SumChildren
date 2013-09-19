SumChildren
==========

This is a demo OS X Core Data app that works except for two issues in updating dependent attributes.  See https://devforums.apple.com/message/892973#892973

Project has two entities in a parent/child relationship…
 
- Parent and child data are presented in separate table views.
- The child object has 3 decimal type attributes: childOne, childTwo, childThree
- The parent has one decimal type attribute, parentSum
- In each child, childThree = childOne * childTwo
- In each parent, parentSum = the sum of all its children's childThree.
- When the user modifies the value of childTwo in a cell, then its childThree, and it's parent's parentSum, should be updated in the table immediately.
 
The two issues are:
 
1. childThree is updated immediately but parentSum is not.  In order to have the modification taken into account, I need to leave the record in the table by selecting another one. Then I see the value updated. It's not a problem with refresh/reload the table, it is really a problem of when the value is updated.
 
2. Modified values are not saved in the SQLite file.
