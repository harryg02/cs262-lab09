# CS 262 Monopoly Webservice

This is the data service application for the 
[CS 262 sample Monopoly project](https://github.com/harryg02/cs262-lab09),
 which is deployed here:
          
- <https://cs262-lab06.azurewebsites.net/>

It has the following read data route URLs:
- `/` a hello message
- `/players` a list of players
- `/players/:id` a single player with the given ID

It is based on the standard Azure App Service tutorial for Node.js.

- <https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli>  

The database is relational with the schema specified in the `sql/` sub-directory
and is hosted on [ElephantSQL](https://www.elephantsql.com/). The database server,
user and password are stored as Azure application settings so that they aren&rsquo;t 
exposed in this (public) repo.

We implement this sample service as a separate repo to simplify Azure integration;
it&rsquo;s easier to auto-deploy a separate repo to Azure. For your team project&rsquo;s 
data service, configure your Azure App Service to auto-deploy from the master/main branch 
of your service repo. See the settings for this in the &ldquo;Deployment Center&rdquo; 
on your Azure service dashboard.
 
 # Questions
1. What are the (active) URLs for your data service?
- /players: To fetch a list of players.
- /players-with-properties: To fetch players along with their properties and cash status. 

2. Which of these endpoints implement actions that are idempotent? nullipotent?
- the GET requests to /players and /players-with-properties are idempotent and nullipotent.

3. Is the service RESTful? If not, why not? If so, what key features make it RESTful.
- Yes, because in monopolyService.js,  it's Stateless, using json, using HTTP and its methods, and using URI for Resource identification. 

4. Is there any evidence in your implementation of an impedance mismatch?
- No, it's not, it directly uses SQL queries within the JavaScript code.
