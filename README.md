**DEVEXTREME REACT GRID WITH CRUD OPERATION**

This project is constructed using **ReactJS** for frontend, **Phoenix framework** for backend and **PostgreSQL** for database.

1)Open assets --> js --> src --> components --> MedicineCard.js and Test.js. 
MedicineCard.js Contains the devextreme react editable grid code with axios API calls for CRUD operation.

2)Remount.js is used to connect react with phoenix framework. Remount can mount any react component in your HTML as a custom element

3)Now go back and open lib --> updatedMedicine_web --> controllers -->medicine_controller.ex.
Here you can find the controller file where it handles the data from database to the application withe create,show,update and delete functions

4)Go back to lib folder --> router.ex. 
Here you can see the routes for api calls

5)Go back to lib folder --> templates --> page -->index.html.eex. 
Here you can find the react element which is defined in remount (assets/js/src/app.js). This will help to show the grid.


