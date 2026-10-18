const app = require("./app");
// const UserModel = require('./models/user.model')
const db = require('./config/db')

const port = 3000;

app.get('/',(req,res)=>{
    // this is home page test
    console.log("Home page request received");
    console.log("\n >" + req.headers)

    res.send("Home page test   \nHello World")
    console.log("Home page response sent");
})


app.listen(port,()=>{
    console.log(`Server Listening on Port http://localhost:${port}`);
})