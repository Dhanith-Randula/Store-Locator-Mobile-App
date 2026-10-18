
const ShopService = require('../services/shop.service');


/*
exports.createShop =  async (req,res,next)=>{
  
    try {
       
        console.log(req.body,"req.body");
        const { ownerName,
            shopName,
            address,
            phoneNumber,
            longitude,
            latitude } = req.body;
        let itemData = await ShopService.createShop(
            ownerName,
            shopName,
            address,
            phoneNumber,
            longitude,
            latitude);
            
           
            
            

        console.log("itemData \n >",itemData);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}
*/


exports.createShop = async (req, res, next) => {
  console.log("createShop in controller in backend");
  try {
    const {
        name,
        shopName,
        email,
        location,
        coordinates,
        address,
        ownerName,
        ornaName,
        categories,
        description,
        photos,
        openingHours,
        contactNumber,
        isVerified
    } = req.body;

    const resolvedName = name || shopName;
    const resolvedShopName = shopName || name;
    
    const shopData = await ShopService.createShop(
      resolvedName,
      email,
      location,
      coordinates,
      ownerName,
      ornaName,
      categories,
      description,
      photos,
      openingHours,
      contactNumber,
      isVerified,
      resolvedShopName,
      address
    );
    res.json({
      status: true,
      success: shopData
    });
  } catch (error) {
    console.log(error, 'err---->');
    next(error);
  }
};

// get shop by id
exports.getShop = async (req, res, next) => {
  console.log("getShop in controller in backend");
  try {
    const shopData = await ShopService.getShop();
    res.json({
      status: true,
      success: shopData
    });
  } catch (error) {
    console.log(error, 'err---->');
    next(error);
  }
};

// get shop by id

exports.getShopById = async (req, res, next) => {
  console.log("getShopById in controller in backend");
  try {
    const {
      id
    } = req.query;
    const shopData = await ShopService.getShopById(id);
    res.json({
      status: true,
      success: shopData
    });
  } catch (error) {
    console.log(error, 'err---->');
    next(error);
  }
};
