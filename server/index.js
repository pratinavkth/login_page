const express = require('express');
const mongoose = require('mongoose');
// const mongoose = require('mongoose');
const app = express();
const DB= "mongodb+srv://pratinavkothia123:OPMYweqiPCmbFw3W@cluster0.jfbv7vg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
const port = 3000;

// app.get('/',(req,res)=>{
//     res.send('Hello World');
// });
const authController = require('./controller/auth');

app.use(express.json());
app.use(authController);

mongoose.connect(DB).then(()=>{
    console.log("Connected to the database");
}).catch(e=>{
    console.log(e);

});

// mongoose.connect(DB).then(()=>{
//     console.log("connected to database");
// }).catch(e=>{
//     console.log(e);
// });


app.listen(port,()=>{
    console.log(`Server is running on port ${port}`);});
