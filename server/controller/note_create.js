const express = require("express");
const NewNote = require('../models/new_note');
const User = require('../models/user');
const authcheck =require('../middelewares/authcheck.js');

const noteCreate = express.Router();
console.log("Note Create Intercepted");
noteCreate.use(authcheck);

noteCreate.post('/api/note_create',authcheck,async(req,res)=>{
    try {
        
        const {title,content} = req.body;
        const userId = req.user;
        console.log(req.body);
        console.log("User ID:",userId);

        if(!userId){
            return res.status(400).json({message:"user ID not found please log in"});
        }
        let note = new NewNote({
            title,
            content,
            userId,
            Date:new Date(),
        });
        note = await note.save();

        const user = await User.findById(userId);
        if (!user) {
            return res.status(400).json({ message: "User not found" });
        }
        user.notes.push(note._id);
        await user.save();
        res.json(note);
        // console.log("User ID:", userId);

    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

noteCreate.get('/api/note_search',authcheck, async(req,res)=>{
    try{
        const userId = req.user;
        const noteSearch = await NewNote.findOne({title:req.body.title,userId});
        if(!noteSearch){
            return res.status(400).json({message:"Note does not exist"});
        }
        else{
            res.json({noteSearch, message:"Title found"});
        }
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})
noteCreate.get('/api/notes', authcheck,async(req,res)=>{
    try{
        const userId = req.user;
        // const notes = await NewNote.findOne({userId});
        // const allnotes = await notes.find(); 
        const allnotes = await NewNote.find({ userId });
        if(!allnotes){
            return res.status(400).json({message:"Note does not exist"});
        }
        else{
            res.json({allnotes, message:"Title found"});
        }
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});

noteCreate.get('/test-middleware', authcheck, (req, res) => {
    res.json({ message: "Middleware is working!", userId: req.user });
});





module.exports = noteCreate;