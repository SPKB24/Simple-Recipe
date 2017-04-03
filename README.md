# Simple-Recipe

### Statement
Our project aims to allow the user to input basic food items they have around and have a recipe generated out of those ingredients. The recipe will be random each time with a link provided to the recipe.

### Analysis
- We will use recursion to parse the JSON to find recipes that best fit the users needs.
- map/filter/reduce will be used to further cut down our list of recipes as needed. 
- We will have seperate functions to request, parse, and display data. It makes for cleaner and scalable code.

### External Technologies
You are encouraged to develop a project that connects to external systems. For example, this includes systems that:
- We plan to use yummly's api to look up foods https://developer.yummly.com/documentation
- Racket GUI library. Will be used to display information to user.
- Racket JSON library. Will be used to get information from data sets.

### Data Sets or other Source Materials
For our data set we plan to use yummly. 
- https://developer.yummly.com/documentation
Using this data we will be able to provide more options for the user. This data will help provide the user with a more diverse recipe list and make our lives easier. 

### Deliverable and Demonstration
Upon completion of the project we should be able to give a live demo of it. To be more explicit, the final product will allow the user to input food items they have in a simple GUI. After that, they will click a button and get a random recipe that includes the ingredients they entered. This will also come with a link to the website that contains the recipe. During the live demo, people will be able to come up if they like to try it out.

### Evaluation of Results
If we can provide these functions for the user, then we will be successful: 
- Allow the user to input food items
- Provide the user with a unique recipe each time
- Easy to understand UI

## Architecture Diagram
![Architecture Diagram image](/ArchitectureDiagram.png?raw=true "Architecture Diagram image")

The first step will be the user entering in individual ingredients that they have at their disposal. They will also enter items that they would like to blacklist. This could be anything from foods that they are allergic too, or simply don't like to eat. We will use the racket/gui library to create an easy to use GUI for users to enter the information.

Once they have filled in the necessary information, we will make an API call to Yummly (using net/url) requesting a JSON file with recipes that best include the inputted ingredients. We will further parse the list to remove any recipes that have items from your blacklist. To handle JSON file parsing, we will use the JSON library.

One we have our final recipes, we will once again use racket/gui to display them for users to choose from.

## Schedule
### First Milestone (Sun Apr 9)
- We want to focus on being able to pull down recipes from Yummly, and begin to parse them.
- Time permitted, we will also begin to work on the GUI.

### Second Milestone (Sun Apr 16)
Which portion of the work will be completed (and committed to Github) by this day?
- We will work on our GUI. More specifically, we will let users enter their ingredients and blacklist ingredients, and use those to further parse the JSON.
- We will also display the parsed items in our GUI.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
- At this point we would like to have a clean and easy to use GUI for users to use. We want this to be a painless process for people to find recipes that fit their needs.

## Group Responsibilities
### Mike Zurawski @MikeZurawski
- Basic UI work
- Parsing JSON for retrieve food items
- Other miscellaneous tasks

### Sohit Pal @SPKB24
- Setup GUI
- Help with handling API call to Yummly and parsing the resulting JSON
