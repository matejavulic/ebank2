# Online banking application E-Bank 2
# Disclaimer
***This project and its source code should be used for educational purposes only.***
***Fictional names "Ebank", "Ebank 2" "E-bank", "E-bank 2", "Ebanka", "E-banka", "EBANKA", "EBANK", "E-BANKA", "E-BANK" as far as fictional bank logos and mottos have been used for illustration purpose only.***

# Description
This is a web application for online banking with all essential features. It allows registered users to manage their bank accounts, transfer funds, get a list of all past transactions, as well as to pay their utility bills.  

# User interface pictures
- Sign Up page  

  ![signup](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/signup.png)
  ![signup](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/signup2.png)
  ![signup](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/signup3.png)
  ![signup](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/signup4.png)
  
- Log in page  

  ![login1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/login1.png)  
  
- Log in page invalid email/no password  

  ![login2](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/login2.png)  
  
 - Log in page forgotten password - password reset using temporary password

  ![reset1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/passreset1.png)
  ![reset1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/passreset2.png)
  ![reset1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/passreset3.png)
  ![reset1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/passreset4.png)
  
- Dashboard page  

  ![dash1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/dash1.png)  

- Transaction details  

  ![dash2](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/dash2.png)  
  
- No transactions  

  ![dash4](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/dash4.png)  
  
- Exchange Rates list (dashboard scrolled down)  

  ![dash3](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/dash3.png) 
 
 - User bank accounts 

  ![dash3](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/accounts.png) 
  
- Drop-down menu  

  ![ddmenu](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/sedemenu.PNG)  
  
- Help section  

  ![help](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/help.png)
  
 - User error example 1 - Unverified user tries to log-in  

  ![error1](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/error1.png)
  
  - User error example 2 - Registered user tries to sign up with the exsitsting e-mail

  ![error3](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/error3.png)
  

# Project details
## Logical structure
From a logical point of view, the system has a 3-tiered REST application architecture. It is a modular client-server architecture that consists of a presentation tier, an application tier and a data tier.

![REST](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/threetierrest3.png)

- **Presentation tier**  
Communicates with other two tiers and holds GUI. It is built with Angular, HTML, CSS, and a TypeScript as a front-end logic. Communication with the other tiers is established through API calls.

- **Application tier**  
Handles application logic. It consists of two separate servers, Node.js server (written in JavaScript) and a Django server (written in Python). Their primary purpose is to support the application’s core functions and fetch/post user data from databases throughout database server calls. 

- **Data tier**  
Stores user related information. The data tier consists of a database server:
    - MySQL server and corresponding database, as far as MySQL DBMS  
   
   MySQL database is used to store users bank account details and all related transaction details. 

## Presentation tier
### Front-end
- **Design principles**  
  User interface design was conducted according to the usability guidelines given in [10 Usability Heuristics for User Interface Design](https://www.nngroup.com/articles/ten-usability-heuristics/) by Jakob Nielsen. It recommends following heuristics for UI design:
  - 1: Visibility of system status  
    *The system should always keep users informed about what is going on, through appropriate feedback within reasonable time.*  
    
    Examples (left picture - Sign In visibility status, right picture - Recent Transactions visibility status):  
    
    ![REST](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/fetch.PNG)
    ![REST](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/fetching%202.PNG)

  - 2: Match between system and the real world  
     *The system should speak the users' language, with words, phrases and concepts familiar to the user.*  
     
     One way to accomplish this requirement is to use metaphor to symbolically represent abstract idea of a real world experience. For example, opposite arrows icon can be a good real life metaphor for banking transactions:  
     
      ![REST](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/methaphore.PNG)
     
  - 3: User control and freedom  

  - 4: Consistency and standards  
  *Users should not have to wonder whether different words, situations, or actions mean the same thing.*  

    During front-end development, [Google Material Design](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/#principles) principles were followed.

  - 5: Error prevention  
  
  - 6: Recognition rather than recall  
  *Minimize the user's memory load by making objects, actions, and options visible.*  

    Stylized door icon can be a good replacement for *Sign out* label:  
    
    ![REST](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/recognize.PNG) 
   
  - 7: Flexibility and efficiency of use  
  *Accelerators — unseen by the novice user — may often speed up the interaction for the expert user.*  
  Three out of six [Gestalt grouping principles of visual perception](https://webspace.ringling.edu/~ccjones/curricula/07-08/seqdesign/Gestalt.pdf) were used during development:
   - Similarity
   - Symmetry
   - Closure  
   
     Example of the closure and similarity principles:  
   
     ![Gestalt](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/gestalt1.PNG)  
   
     Example of the symmetry principle:  
   
     ![Gestalt2](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/gestalt2.PNG)
    
  - 8: Aesthetic and minimalist design  
  *Dialogues should not contain information which is irrelevant or rarely needed. Every extra unit of information in a dialogue competes with the relevant units of information and diminishes their relative visibility*.

  - 9: Help users recognize, diagnose, and recover from errors  
  *Error messages should be expressed in plain language (no codes), precisely indicate the problem, and constructively suggest a solution.*

  - 10: Help and documentation  
  *Even though it is better if the system can be used without documentation, it may be necessary to provide help and documentation. Any such information should be easy to search and focused on the user's task.*  
   Help section is mainly focused on a video help instructions, because they are:  
     - Easy to understand
     - Short 
     - Easily seen
     - Contain minimum amount of task specific information  
     
- **Component organisation and architecture**  
  Each Angular front-end component consists of three files (optionally +1 as with a unit test purposes):
   - HTML template
   - CSS template
   - TypeScript controller  
   
  TypeScript controller's task is to store all variables relevant for component HTML part as far as functions to make calls
  for service controllers (service controllers are TypeScript modules which initiate API server calls).
- **Services**
  - Authentication service
  - Dashboard service
  - Posts service
  - Auth guard
  - Auth interceptor
  
## Application tier
### Node.js server
This is the main application server. It communicates with database and Django server through an API server calls.

Server is capable of executing following tasks:
 - User Sign Up/Sign In
 - Tokenization service (auto authentication if user authenticated user close or reloads web page, auto user sign out after token expiration)
 - Handling HTTP PUT, POST and GET requests
 - Getting all user information from databases (make database queries)
 - MIME type validation and image upload handling
 - Formatting and preparing data in convenient format to be shown on front end
 - Creating, editing and deleting of user transactions
 
### Django API service
This server has two implemented API services:
 - **Dummy data service**  
   When a new user signs up, this service sends random JSON object to Node.js sever upon request. JSON object contains random data (mobile phone number, branch name, and home address) pulled out of .csv file (or as a random number in case of phone number) on Django API service. After data receiving, Node.js server updates corresponding user data in MySQL database with the data provided.  
   
 - **Exchange rates service**  
    This service sends API calls to the free [Exchange rates API](https://api.exchangeratesapi.io/), formats retrieved data and stores it in sqlite3 database. Upon request, API service returns json data with current exchange rate list read from database and sends it back to the Node.js server.  
 
## Data tier
### MySQL database
Database holds data related to a user account, user transactions, user cards and profiles. The database EER can be found in Documentation.

- **Real-world database (work in progress)**  
  This database has been developed according to the several international standards used in an IT banking systems:  
  
  - **ISO 20022 Financial Services - Universal financial industry message scheme**  
    As a result of guidelines and schemes presented in this standard, following tables were modeled:  
    
    ![transactionCode](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/transactnCode.PNG)  
    
    Example:  
    Suppose we want to list last nine possible transaction codes and its corresponding names related to Issued Real-Time Credit Transfer payments (as defined in ISO 20022).  
    After querying inner join sql instruction we would get the next query result:  
    
    ![queryRes](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/transactionCodes.PNG)  
    
  - **BAI2 codes**  
    ISO 20022 suggests using the BAI code appended to the transaction code. So, the following table is created, and together with
    transaction code table uniquely identifies transaction type:  
    
    ![transactionType](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/transactionType.PNG)  
    
  - **ISO 18245:2003 Retail financial services** - Merchant category codes (MCC)  
    This standard was used for the merchant category table modeling. This table stores MCC codes upon which all electronic payments (card payments) are standardized and categorized.  
    
     ![mcc](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/Merchant.PNG)  
     
   - **ISO 3166-1 alpha-3** - Three-letter country codes   
   
      ![alpha3](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/Country%20code.PNG)  
      
   - **ISO 4217** - Currency designators  
     This standard delineates currency designators, country codes (alpha and numeric), and references to minor units.
     It was used for the creation of currency codes table.
   
      ![alpha3](https://raw.githubusercontent.com/matejavulic/E-BANK-Web-App/master/pictures/Currency.PNG)  

Complete EER diagram of the database can be seen [here](https://github.com/matejavulic/Ebank-Web-App/blob/master/pdfs/EER_diagram_database.pdf).

# Build
Run `ng build` to build the project. The build artifacts will be stored in the `dist/`directory. Use the `--prod` flag for a production build. 

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).

# Servers
## Front-end development server setup 
Run `ng serve` to start a development server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.
## Back-end servers setup
### Node server
Run `npm run start:server` to start a Node.js server.

### MySQL server
Download MySQL Installer from its [official website](https://dev.mysql.com/downloads/installer/) and install:
- MySQL Community Server 8.0.17
- MySQL Workbench 8.0.17.  
If everything goes without errors, MySQL server daemon should be automatically  started.

### Django API Service
Download and install:  
- Python from its [official website](https://www.python.org/downloads/)
- Django framework with `pip install Django==2.2.4`
- Install virtual environment with `pip install virtualenv`
  - Launch virtualenv env in cmd
  - Start new environment `cd your_project virtualenv env`
  - Activate virtualenv (on Windows) `cd \env\Scripts\activate.bat`
  - Now install following Python libraries:  
    `pip install numpy pandas request`  
    
In order to run a Django API, do the following:
- Change working directory to `cd \server-python\env\pythonserver`
- Start a server with `python manage.py runserver 3002`
- To check if server works, head to http://127.0.0.1:3002/randomUserData/.

# Further development

## Front-end
  - Adding user ability to get an graphical report on a statistics of its bank account with [plotly](https://plot.ly/). 
## Back-end  
  - Adding two new types of web app authentication:  
    - Mobile device token
    - Fingerprint biometric authentication
    - QR code payments
    
# Contact
If you have any questions, feel free to write me an e-mail at matejavulic@gmail.com .
