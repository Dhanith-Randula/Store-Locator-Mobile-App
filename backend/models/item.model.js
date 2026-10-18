const db = require('../config/db');
//const UserModel = require("./user.model");
const mongoose = require('mongoose');
const ShopModel = require('./shop.model');
const { Schema } = mongoose;

const ItemSchema = new Schema({
    
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    itemType: {
        type: String,
        //required: true
    },

    price:{
        type:String,
        required:true
    },
    shopName:{
        type:String,
        //required:true

    },
    // location longitude and latitude as array
    location:{
        type:[Number],
        //required:true
    },

    shopId:{
        type: Schema.Types.ObjectId,
        ref: ShopModel.modelName
        //required:false
    }
},{timestamps:true});

const ItemModel = db.model('item',ItemSchema);
module.exports = ItemModel;