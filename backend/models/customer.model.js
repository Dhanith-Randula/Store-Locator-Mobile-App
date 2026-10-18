const db = require('../config/db');
//const UserModel = require("./user.model");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const CustomerSchema = new Schema({
    
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    phoneNumber:{
        type: String,
        required: true
    },
    
    username:{
        type:String,
        required:true
    },
    
    
},{timestamps:true});

const CustomerModel = db.model('customer',CustomerSchema);
module.exports = CustomerModel;

