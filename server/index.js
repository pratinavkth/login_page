const express = require('express');
const mongoose = require('mongoose');
const dotnev = require('dotenv');
// const mongoose = require('mongoose');

dotnev.config();
const app = express();
const DB= process.env.MOONGODBURL;
const port = process.env.PORT;


console.log("Received Request");
// app.get('/',(req,res)=>{
//     res.send('Hello World');
// });
const authController = require('./controller/auth');

const noteCreate = require('./controller/note_create');

app.use(express.json());

app.use(authController);
app.use(noteCreate);


mongoose.connect(DB).then(()=>{
    console.log("Connected to the database");
}).catch(e=>{
    console.log(e);

});
app.listen(port,()=>{
    console.log(`Server is running on port ${process.env.PORT}`);});
