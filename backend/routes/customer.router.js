const router = require("express").Router();

const CustomerController = require('../controller/customer.controller')



router.post("/createCustomer",CustomerController.createCustomer);
// router.get('/getCustomerList',CustomerController.getCustomerList);
// router.delete("/deleteCustomer",CustomerController.deleteCustomer);
// router.put("/updateCustomer",CustomerController.updateCustomer);



module.exports = router;




// // router.get('/getSearchedItemList',ItemController.getItemList)
// // router.delete("/deleteItem",ItemController.deleteItem)
// // router.put("/updateItem",ItemController.updateItem)


// router.post("/createToDo",ToDoController.createToDo);

// router.get('/getUserTodoList'
// // show something in the console to check if the route is working
// // (req,res)=>{
// //     console.log("getUserTodoList")
// // }

// ,ToDoController.getToDoList)

// router.delete("/deleteTodo"
// //check if the route is working
// // (req,res)=>{ 
// //     console.log("deleteTodo")
// // }






// ,ToDoController.deleteToDo)

// router.put("/updateTodo"
// //check if the route is working
// // (req,res)=>{
// //     console.log("updateTodo")

// // }
// ,ToDoController.updateToDo)




// module.exports = router;