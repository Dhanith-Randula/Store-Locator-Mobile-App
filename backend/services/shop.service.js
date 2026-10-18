
const ShopModel = require("../models/shop.model");


// class for shop
class ShopService{
    

    static async createShop(name,email,location,coordinates,ownerName , ornaName , categories,description, photos , openingHours ,contactNumber , isVerified, shopName, address){
      console.log("createShop in backend \n\n");
      const shopDoc = {
        name: name || shopName,
        shopName: shopName || name,
        email,
        address: address || (typeof location === 'string' ? location : undefined),
        location: coordinates ? { type: 'Point', coordinates } : location,
        ownerName,
        categories: Array.isArray(categories) ? categories : (categories ? [categories] : []),
        description,
        photos: Array.isArray(photos) ? photos : (photos ? [photos] : []),
        openingHours,
        contactNumber,
        isVerified: !!isVerified
      };
      if (ornaName) {
        shopDoc.ornaName = ornaName;
      }
      const createShop = new ShopModel(shopDoc);
      console.log("variable to save",createShop + "\n\n");
      return await createShop.save();
    }

      // get shop by id

      static async getShop(){
        console.log("getShop in backend \n\n");
        return await ShopModel.find();
      }

      // get shop by id
      static async getShopById(id){
        return await ShopModel.findById(id);
      }




    }

  
    
module.exports = ShopService;