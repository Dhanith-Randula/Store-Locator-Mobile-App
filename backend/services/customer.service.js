
const ShopModel = require("../models/shop.model");
const CustomerModel = require("../models/customer.model");


// class for shop
class CustomerService{
    static async createCustomer(name,address,phoneNumber,username){
            const createCustomer = new CustomerModel({
              
                name,
                address,
                phoneNumber,
                username

            });
            return await createCustomer.save();
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

    // get shop deatails with id as a parameter
     
    // static async getShop(shopId){
    //   const shop = await ShopModel.findById(shopId)
    //   return shop;
    // }

    // static async getSearchedShopList(userId){
    //     const shopList = await ShopModel.find({userId})
    //     return shopList;
    // }

    static async updateShop(id, ownerName,shopName,address,phoneNumber,longitude,latitude) {
        const UpdatedShop = await ShopModel.findByIdAndUpdate(id, {
          ownerName: ownerName,
          shopName: shopName,
          address: address,
          phoneNumber: phoneNumber,
          longitude: longitude,
          latitude: latitude
        }, {
          new: true // Return the updated document
        });
        return UpdatedShop;
      }






    

    // static async updateToDo(id, title, description) {

    
    //   try {
    //     const updatedTodo = await ToDoModel.findByIdAndUpdate(id, {
    //       title: title,
    //       description: description
    //     }, {
    //       new: true // Return the updated document
    //     });
    
    //     return updatedTodo;
    //   } catch (error) {
    //     console.error("Error updating:", error);
    //     throw error; // Rethrow the error for further handling
    //   }
    //  }
    
    
    }




// class for item
// class ItemService{
//     static async createItem(name,description,price,shopName,shopId){
//             const createItem = new ItemModel({
              
//               name,
//               description,
//               price,
//               shopName
//               //,
//               //shopId
//             });
//             return await createItem.save();
//     }
//     // dummy data
//     // {
//     //     "itemId":"5f9b3b3b9b0b7e2b7c3b3b9b",
//     //     "name":"item1",
//     //     "description":"item1 description",
//     //     "price":100,
//     //     "shopName":"shop1",
//     //     "shopId":"5f9b3b3b9b0b7e2b7c3b3b9b"
//     // }

//     static async getSearchedItemList(userId){
//         const itemList = await ItemModel.find({userId})
//         return itemList;
//     }

//     static async updateToDo(id, title, description) {

    
//       try {
//         const updatedTodo = await ToDoModel.findByIdAndUpdate(id, {
//           title: title,
//           description: description
//         }, {
//           new: true // Return the updated document
//         });
    
//         return updatedTodo;
//       } catch (error) {
//         console.error("Error updating:", error);
//         throw error; // Rethrow the error for further handling
//       }
//      }}




// // class ToDoService{
// //     static async createToDo(userId,title,description){
// //             const createToDo = new ToDoModel({userId,title,description});
// //             return await createToDo.save();
// //     }

// //     static async getUserToDoList(userId){
// //         const todoList = await ToDoModel.find({userId})
// //         return todoList;
// //    }
// //    static async updateToDo(id, title, description) {

    
// //      try {
// //        const updatedTodo = await ToDoModel.findByIdAndUpdate(id, {
// //          title: title,
// //          description: description
// //        }, {
// //          new: true // Return the updated document
// //        });
   
// //        return updatedTodo;
// //      } catch (error) {
// //        console.error("Error updating:", error);
// //        throw error; // Rethrow the error for further handling
// //      }
// //     }
   




   

   







// //    static async deleteToDo(id){

// //         // this is delete function
// //         console.log("this is delete function");

// //         const deleted = await ToDoModel.findByIdAndDelete({_id:id})
// //         // show in console deleted
// //         console.log("deleted");
// //         return deleted;
// //    }

 




// // }

module.exports = CustomerService;