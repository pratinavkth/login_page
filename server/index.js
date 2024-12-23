const express = require('express');
const mongoose = require('mongoose');
// const mongoose = require('mongoose');

const app = express();
const DB= "mongodb+srv://pratinavkothia123:OPMYweqiPCmbFw3W@cluster0.jfbv7vg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
const port = 3000;


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
    console.log(`Server is running on port ${port}`);});
