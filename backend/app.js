const express = require("express");
const bodyParser = require("body-parser");

const UserRoute = require("./routes/user.routes");
// const ToDoRoute = require('./routes/todo.router');
const ItemRoute = require('./routes/item.router');
const ShopRoute = require('./routes/shop.route');
const CustomerRoute = require('./routes/customer.router');
const app = express();

// Enable CORS for mobile & web clients
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    if (req.method === "OPTIONS") {
        return res.sendStatus(200);
    }
    next();
});

app.use(bodyParser.json());

app.use("/", UserRoute);
//  app.use("/", ToDoRoute);
app.use("/", ItemRoute);
app.use("/", ShopRoute);
app.use("/", CustomerRoute);

// Centralized JSON error handling
app.use((err, req, res, next) => {
    console.error("API Error:", err.message || err);
    res.status(err.status || 400).json({
        status: false,
        error: err.message || "An unexpected error occurred"
    });
});

module.exports = app;