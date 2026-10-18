// const { deleteToDo } = require("../controller/todo.controller");
// const ToDoModel = require("../models/todo.model");
const ItemModel = require("../models/Item.model");




// class for item
class ItemService{
    static async createItem(name,description,itemType,price,location,shopName,shopId){
      console.log("\n this is createItem service varibles \n >",name,description,itemType,price,shopName,shopId)     ; 
      const createItem = new ItemModel({
              name,
              description,
              itemType,
              price,
              location,
              shopName,
              shopId
              
            });

            console.log("\n this is createItem function varibles \n >",createItem)     ;
            return await createItem.save();
    }
    // dummy data
    // {
    //     "itemId":"5f9b3b3b9b0b7e2b7c3b3b9b",
    //     "name":"item1",
    //     "description":"item1 description",
    //     "price":100,
    //     "shopName":"shop1",
    //     "shopId":"5f9b3b3b9b0b7e2b7c3b3b9b"
    // }

    static async getSearchedItemList(shopId){
        const itemList = await ItemModel.find({shopId})
        return itemList;
    }

    static async getItemListInShop(shopId){
        console.log("\n this is getItemListInShop service varibles \n >",shopId)     ;  
        const itemList = await ItemModel.find({shopId})
        return itemList;
    }

    static async getItemsWithName(name){
        console.log("\n this is getItemsWithName service varibles \n >",name)     ;  
        const itemList = await ItemModel.find({name})
        return itemList;
    }

    // static async updateToDo(id, title, description) {

    
    //   try {
    //     // const updatedTodo = await ToDoModel.findByIdAndUpdate(id, {
    //     //   title: title,
    //     //   description: description
    //     // }, {
    //     //   new: true // Return the updated document
    //     // });
    
    //     return updatedTodo;
    //   } catch (error) {
    //     console.error("Error updating:", error);
    //     throw error; // Rethrow the error for further handling
    //   }
    //  }
    }




// class ToDoService{
//     static async createToDo(userId,title,description){
//             const createToDo = new ToDoModel({userId,title,description});
//             return await createToDo.save();
//     }

//     static async getUserToDoList(userId){
//         const todoList = await ToDoModel.find({userId})
//         return todoList;
//    }
//    static async updateToDo(id, title, description) {

    
//      try {
//        const updatedTodo = await ToDoModel.findByIdAndUpdate(id, {
//          title: title,
//          description: description
//        }, {
//          new: true // Return the updated document
//        });
   
//        return updatedTodo;
//      } catch (error) {
//        console.error("Error updating:", error);
//        throw error; // Rethrow the error for further handling
//      }
//     }
   




   

   







//    static async deleteToDo(id){

//         // this is delete function
//         console.log("this is delete function");

//         const deleted = await ToDoModel.findByIdAndDelete({_id:id})
//         // show in console deleted
//         console.log("deleted");
//         return deleted;
//    }

 




// }

module.exports = ItemService;