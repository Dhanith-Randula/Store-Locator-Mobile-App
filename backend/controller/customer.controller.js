
// const ItemService = require('../services/item.service');
const CustomerService = require('../services/customer.service');


exports.createCustomer =  async (req,res,next)=>{

    console.log("this is createCustomer request receved" );

    try {   
    
    
    
        const { 
            name,
            address,
            phoneNumber,            
            username } = req.body;

            // dummy data for postman
            



        let customerData = await CustomerService.createCustomer(
                name,
                address,
                phoneNumber,
                username,
                );

        res.json({status: true,success:customerData});
    } 
    catch (error) {
                console.log(error, 'err---->');
                next(error);
    }

}





    // console.log("this is createItem request receved" );
    // try {
    //     // show reqest 
        
    //     //console.log(req.headers,"req.headers");
    //     console.log(req.body,"req.body");
    //     const { name,description,price,shopName,shopId } = req.body;
    //     let itemData = await ItemService.createItem(
    //         name,
    //         description,
    //         price,
    //         shopName,
    //         shopId);
    //     console.log("itemData \n >",itemData);
    //     res.json({status: true,success:itemData});
    // } catch (error) {
    //     console.log(error, 'err---->');
    //     next(error);
    // }



// name price description
exports.getSearchedItemList =  async (req,res,next)=>{
    try {
        const { name } = req.query;
        //let itemData = await ItemService.getSearchedItemList(name);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}




exports.getToDoList =  async (req,res,next)=>{


    // show reqest headers
    console.log(req.headers,"req.headers");

    const { id: userId } = req.query;
    // show params
    console.log(req.query,"req.query");
    //show id
    console.log(userId,"id");
    console.log(req.body,"req.body");
    try {
        //const { userId } = req.body;
        //let todoData = await ToDoService.getUserToDoList(userId);
        console.log(todoData,"todoData")    
        res.json({status: true,success:todoData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

// get to do list with id as a parameter
exports.getToDoListWithId =  async (req,res,next)=>{
    try {
        const { id } = req.params;
        // let todoData = await ToDoService.getUserToDoList(id);
        res.json({status: true,success:todoData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}






exports.deleteToDo =  async (req,res,next)=>{
    // show in console this is delete function
    console.log("this is delete function");
    const { id: userId } = req.query;
    // show in console id
    console.log(userId,"id");
    try {
        // const { id } = req.body;
        // // show in console id
        // console.log(id,"id");
        // let deletedData = await ToDoService.deleteToDo(userId);
        res.json({status: true,success:deletedData});
    } catch (error) {
        //console.log(error, 'err---->');
        next(error);
    }
    
}

// update to do list

exports.updateToDo =  async (req,res,next)=>{

    // show in console this is update function
    console.log("this is update function");
    const { id: userId } = req.query;
    // show in console id
    console.log(userId,"id");

    try {
        const { id,title,desc } = req.body;
        // let updatedData = await ToDoService.updateToDo(userId,title,desc);
        res.json({status: true,success:updatedData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}








