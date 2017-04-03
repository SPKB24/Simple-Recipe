# Simple-Recipe

### Statement
Our project aims to allow the user to input basic food items they have around and have a recipe generated out of them. The recipe will be random each time and the UI will provide a link to the recipe.

### Analysis
Explain what approaches from class you will bring to bear on the project.

Be explicit about the techiques from the class that you will use. For example:

- Will you use data abstraction? How?
- Will you use recursion? How?
- Will you use map/filter/reduce? How? 
- Will you use object-orientation? How?
- Will you use functional approaches to processing your data? How?
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?
- Will you use lazy evaluation approaches?

The idea here is to identify what ideas from the class you will use in carrying out your project. 

**Your project will be graded, in part, by the extent to which you adopt approaches from the course into your implementation, _and_ your discussion about this.**

### External Technologies
You are encouraged to develop a project that connects to external systems. For example, this includes systems that:
- We plan to use walmart's api to look up foods https://developer.walmartlabs.com/docs/read/JSONP_Response
- Racket GUI library. Will be used to display information to user.
- Racket JSON library. Will be used to get information from data sets.

### Data Sets or other Source Materials
For our data sets we plan to use walmarts api and/or openfoodfacts data.
- https://developer.walmartlabs.com/docs/read/JSONP_Response
- https://world.openfoodfacts.org/data
Using this data we will be able to provide more diverse options for the user. These data sets will help provide the user with a more diverse recipe list and make our lives easier. 

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

### Evaluation of Results
If we can provide these functions for the user, then we will be successful: 
- Allow the user to input food items
- Provide the user with a unique recipe each time
- Easy to understand UI

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
### First Milestone (Sun Apr 9)
Which portion of the work will be completed (and committed to Github) by this day? 
- Basic functionality.
- - Our hope is to allow the user to enter food items and have a recipe displayed.

### Second Milestone (Sun Apr 16)
Which portion of the work will be completed (and committed to Github) by this day?
- UI work
- - Basically our goal is to finish up the UI and make it look pretty. Alongside with this, we hope to finish up any other remaining tasks.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
- 

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

Please use Github properly: each individual must make the edits to this file representing their own section of work.

- Mike Zurawski
- - Basic UI work
- - Parsing JSON for retrieve food items
- - Other miscellaneous tasks

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Susan Scheme @susanscheme
will write the....

### Leonard Lambda @lennylambda
will work on...

### Frank Funktions @frankiefunk 
Frank is team lead. Additionally, Frank will work on...   
