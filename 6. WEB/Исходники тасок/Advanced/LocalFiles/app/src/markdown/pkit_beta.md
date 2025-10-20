# PKit - Policy Kit (rev 0.2) conceptual implementation

Ruby framework designed to simplify the process of implementing PBACL,
including system for Role management, policy priority management, presets
for Discretionary/Mandatory modes of operation, and much more.

Implementation
--------------

PKit works on the premise of following principles:

- Everything that is subject to control is an object.
- Every object is an element of a certain Class of objects.
- Classes themselves are objects that are subject to control.
- Every object belongs to some other object - by default it's the entity
  that created it and the entity that is considered its parent, or in case
  neither is there - the object pool itself becomes the parent. Classes are
  assigned to the object pool regardless of the above.
- Every object is thus placed in a tree hierarchy, and every object is
  inevitably a child of the object pool.
- An object may belong as a child to multiple hierarchies, but may never
  recursively be a child of itself.
- System contains Users (Class), which are a universal class of objects
  applied to any entity that may enact upon objects (including other users).
- Only Users may trigger actions that manipulate object state.
- There is at least 1 User, by default, that user being the System user.
- System contains Roles (Class), which are groups that define the priority
  of the Policy enacted by a User, or action taken by a User
- Roles adhere to the following rules:
  - System user always has higher priority than any other Role or User.
  - Any given User may have from 0 to any amount of Roles.
  - Users may be assigned to Roles (promoted) by adding them as a child of
    the Role. Conversely, Users may have their Role removed (demoted) by
    deleting them as a child of the Role.
  - Users that do not have any Role have the lowest priority.
  - Roles of equal priority may not demote eachother (or thesmelves) or
    promote Users to role of the same priority.
  - A User's priority is defined by the highest priority Role that the user
    is a part of. (subject to change)
- System contains Policies (Class), which define the ability of a user to
  manipulate an object.
- Policies adhere to the following rules:
  - In abscence of allowing Policies, any action is prohibited.
  - Any given policy inherits the priority of the highest Role the User that
    created it is a part of.
  - Any Role that is the greater or equal to the priority of the Policy may
    manipulate it.
  - No policy can dictate actions of the Roles whose priority is greater or
    equal than that of the policy.
  - Policies themselves are objects of Policies
  - Roles are also objects of Policies
  - Policies are designed to address questions with answers in form
    "`(User|{USER SELECTOR}) (May|May not) do ({ACTION}) on (Object|Any
    instance of Class) [(Where {CONDITION})] [On child of {Object}]`"
  - Policies of higher priority take precedence over policies of lower
    priorities.
  - If two conflicting policies are in action and both have equal priority,
    the prohibiting one takes precedence over the one allowing the action.

Rationale
---------

- There is a need for Users to exist to express the external force driving
  state changes in an otherwise static structure of objects.
- There is a need for Roles to exist to express the concept of priority in a
  User-agnostic way.
- There is a need for Classes to exist to express the natural concept of
  ontological categories, and in particular, universals.
- There is a need for Objects to exist to distinct ontological particulars
  in the description of policies.
- There is a need for Policies to exist to regulate the ability of Users to
  act upon Objects and Classes, which include Users themselves.

Given this structure and a flexible enough framework for defining policies,
it should be easy to declare Discretionary, Mandatory and Role-based ACLs,
and, if needed, mix and match non-conflicting features of all of the above.
