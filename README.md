# Simple-Recipe

### Statement
Our project aims to allow the user to input basic food items they have around and have a recipe generated out of those ingredients. The recipe will be random each time with a link provided to the recipe.

### Analysis
- We used recursion to parse the JSON to find recipes that best fit the users needs.
- We split up our code into seperate functions to request, parse, and display data. It makes for cleaner and scalable code.

### External Technologies
- Yummly: Yummly's api to look up foods and recipes: https://developer.yummly.com/documentation
- Racket GUI library. Used to create a clean, simple UI to display information to users.
- Racket JSON library. Used to parse the JSON responses from Yummly API Calls.

### Data Sets or other Source Materials
For our data set we plan to use yummly.
- https://developer.yummly.com/documentation
Using this data we will be able to provide more options for the user. This data will help provide the user with a more diverse recipe list and make our lives easier.

### Deliverable and Demonstration
Upon completion of the project we should be able to give a live demo of it.

Staying true to the project name, we will only require the user to enter foods' that they like, and foods' that they dislike, then click submit to pull up a recipe which best fits their inputs. To get another recipe, just click submit again.

### Evaluation of Results
If we can provide these functions for the user, then we will be successful:
- We have allowed the user to input food items
- We have provided the user with a unique recipe each time
- We have an easy to understand UI

## Architecture Diagram
![Architecture Diagram image](/ArchitectureDiagram.png?raw=true "Architecture Diagram image")

The first step will be the user entering in individual ingredients that they have at their disposal. They will also enter items that they would like to blacklist. This could be anything from foods that they are allergic too, or simply don't like to eat. We will use the racket/gui library to create an easy to use GUI for users to enter the information.

Once they have filled in the necessary information, we will make an API call to Yummly (using net/url) requesting a JSON file with recipes that best include the inputted ingredients. We will further parse the list to remove any recipes that have items from your blacklist. To handle JSON file parsing, we will use the JSON library.

One we have our final recipes, we will once again use racket/gui to display them for users to choose from. Information that is displayed includes the ingredeints, nutritional facts, link to the preparation details, a picture of the finished product, and more!

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
- Handled Yummly API call and response
- Parsed the response to provide data for the GUI
