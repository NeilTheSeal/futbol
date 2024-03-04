# Turing Mod 1 Futbol Project README

## Check-ins
- We will communicate via Slack several times a day at least
- We will do at least one Zoom call a day

## Plan for project organization and workflow
- We have set up a [GitHub projects page](https://github.com/users/NeilTheSeal/projects/2)
- We are using [Miro](https://miro.com/app/board/uXjVNoUgUOE=/?share_link_id=491775417603) for whiteboarding
- Group norms are in docs/group_norms.md

## Approaches for project organization
- Git workflow - we had to decide on a naming convention for branches and how often to commit
- We wanted to try Miro because it seems more developer-friendly than Freeform
- We preferred GitHub Projects over Trello because of its integration with our repository

## Approach to code design
- What classes do we need?
  - StatTracker
    - This is the "main" class that all functionality is tied to
  - Game
    - This includes both instance methods and class methods
      - Instance methods: things like .won?
      - Class methods: for creating multiple Game instances, and calculating statistics about games
  - Team
    - Also includes instance and class methods
  - GameTeam
    - Includes instance and class methods
- How to break this out into pieces that individuals or pairs can work on?
  - Give one class responsibility to each person
  - Can do driver/navigator at the beginning of each class, and hand off tasks thereafter
  - Async: write code snippets or pseudocode in the Miro and hand that off to another person for implementation
- How do we know when something is "good enough"?
  - If it passes the spec harness tests and our unit/integration tests

## Link to "Define the Relationship"
- [DTR](https://docs.google.com/document/d/1lpanxrDJjw6f3paF7eL6Kqx28IkDTppuKmc_9heUfBc/edit)

## Contributors
- Neil Hendren
  - [LinkedIn](https://www.linkedin.com/in/neilhendren/)
  - [GitHub](https://github.com/NeiltheSeal)
- Jared Hobson
  - [LinkedIn](https://www.linkedin.com/in/jared-hobson-639817241/)
  - [GitHub](https://github.com/JaredMHobson)
- Rodrigo Chavez
  - [LinkedIn](https://www.linkedin.com/in/rodrigo-chavez-1b93a52b1/)
  - [GitHub](https://github.com/RodrigoACG/)

## Name and links to tools used for retro
- [Miro](https://miro.com/app/board/uXjVNoUgUOE=/?share_link_id=491775417603)
- [Atlassian Retro Instructions](https://www.atlassian.com/team-playbook/plays/retrospective#instructions)

## Top 3 things that went well
- Communication has been solid, both over Slack and over Zoom
- Project planning and creating a foundation was very effective
- We were all on the same page and worked well together

## 3 Things to improve on
- Ask for help when you need it
- More driver/navigator and group work
- Asking more technical questions

## Reflection

- What was the most challenging aspect of this project?
  - Staying motivated to finish up the project.
  - Not giving up when things got challenging


- What was the most exciting aspect of this project?
  - Working with new people is always a good way to learn collaboration skills.
  - It was cool to integrate all of the technical skills we have learned so far into a single project.
  - Seeing the project come together at the end was very satisfying.


- Describe the best choice enumerables you used in your project. Please include file names and line numbers.
  - The .map method reduced our `stat_generator.seasons` method to a single line (stat_generator.rb:275)
  - We used the `each` method many times (stat_generator.rb:103)
  - We used the `count` method (stat_generator.rb:41)
  - We also used the `sum` method (stat_generator.rb:251)


- Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
  - We did not use superclasses or modules. We chose not to use them because it was not necessary.


- Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
  - `"can generate a hash of team stats by season"` - stat_generator_spec.rb:238. I was proud of this because it is a robust way of determining whether a hash has the expected format.
  - `"can display the winningest coach"` - stat_generator_spec.rb:274. This was an integration test I was proud of because it integrates several helper methods.


- Is there anything else you would like instructors to know?
  - We would like some input about methods we could have shortened or made more efficient. Also, with nested iterations we were wondering if there was a faster way (stat_generator.rb:214)
  - We were wondering if there was a different way we could lay out our classes and methods to adhere more to SRP and be better organized.