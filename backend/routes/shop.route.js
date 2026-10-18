const router = require("express").Router();
const ShopController = require('../controller/shop.controller')


router.post("/createShop",ShopController.createShop);
// get shop by id
router.get('/getShopbyid',ShopController.getShopById);


module.exports = router;

