const db = require('../config/db');

const mongoose = require('mongoose');
const { Schema } = mongoose;
/*


const mongoose = require('mongoose');

// Define the shop schema
const shopSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true, // Remove extra whitespace from name
  },
  email: {
    type: String,
    required: true,
    unique: true, // Ensure unique email for each shop
  },
  location: {
    type: {
      type: String,
      enum: ['Point'], // Specify type is a point
    },
    coordinates: {
      type: [Number], // Array of 2 elements: [longitude, latitude]
      required: true,
    },
  },
  ownerName: {
    type: String,
    required: true,
  },
  ornaName: {
    type: String, // Unique shop name based on location and business
    unique: true,
  },
  categories: [
    {
      type: String,
      required: true,
    },
  ], // Array of strings for shop categories
  description: {
    type: String,
  },
  photos: [
    {
      type: String, // Store image URLs initially
      required: true,
    },
  ],
  openingHours: {
    type: Object, // Store daily opening and closing times
  },
  contactNumber: {
    type: String,
  },
  isVerified: {
    type: Boolean,
    default: false, // Shop starts unverified until admin approval
  },
});

// Define a geospatial index for efficient location searches
shopSchema.index({ location: '2dsphere' });

// Export the Mongoose model
module.exports = mongoose.model('Shop', shopSchema);

    // ownerName: {
    //     type: String,
    //     required: true
    // },
    // shopName: {
    //     type: String,
    //     required: true
    // },
    // address: {
    //     type: String,
    //     required: true
    // },
    // phoneNumber:{
    //     type: String,
    //     required: true
    // },
    // longitude:{
    //     type: String,
    //     required: true
    // },
    // latitude:{
    //     type: String,
    //     required: true
    // },
 
 */




const ShopSchema = new Schema({
    name: {
        type: String,
        trim: true,
      },
      shopName: {
        type: String,
        trim: true,
      },
      email: {
        type: String,
        unique: true,
      },
      location: {
        type: Schema.Types.Mixed,
      },
      address: {
        type: String,
      },
      ownerName: {
        type: String,
      },
      ornaName: {
        type: String,
        unique: true,
        sparse: true,
      },
      categories: [
        {
          type: String,
        },
      ],
      description: {
        type: String,
      },
      photos: [
        {
          type: String,
        },
      ],
      openingHours: {
        type: Object,
      },
      contactNumber: {
        type: String,
      },
      isVerified: {
        type: Boolean,
        default: false,
      },
});

const ShopModel = db.model('shop',ShopSchema);
module.exports = ShopModel;