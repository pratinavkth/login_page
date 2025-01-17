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

    }catch (e) {
        res.status(500).json({error:e.message});
    }
});

noteCreate.post('/api/note_search',authcheck, async(req,res)=>{
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
noteCreate.post('/api/notes', authcheck,async(req,res)=>{
    try{
        const userId = req.user;
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
}
);


noteCreate.put('/api/noteupdate',authcheck,async(req,res)=>{
    try{
        // const userId = req.user;
        console.log("update note intercepted");
        // const noteId = req.body.noteId;
        const {title,content,noteId} = req.body;
        console.log("note id");
        console.log(noteId);
        console.log(title);
        console.log("noteid");
        if(!noteId){
            res.status(400).json({message:"note is not found"})
        }
        const note = await NewNote.findById(noteId);
        console.log("old note");
        console.log(note);
        if(!note){
           return res.status(400).json({message:"note with this id is not found"});
        }
        if(title)note.title = title;
        if(content) note.content = content;
        note.Date = new Date();
        console.log(note);
        // const updatedNote = 
        await note.save();
        return res.status(200).json({
            message:"Note updated Sucesfully",
            // note: updatedNote,
        });
    }
    catch(e){
    // print(e);
    // console.error("Error updating note",e);
    // return res.status(500).json({
    //     message:"Internal server Error"
    // });
    }
    // const noteId = 
});

noteCreate.delete('/api/deletenote', authcheck,async(req,res)=>{
    // const userId = req.user;
    try{
    const noteId = req.body.noteId;
    if(!noteId){
        res.status(400).json({message:"note is not found"})
    }
    const deletenote = await NewNote.findById(noteId);
    // await NewNote.deleteOne(noteId);
    if(!deletenote){
        return res.status(400).json({message:"noteid is not found"})
    }
    await deletenote.deleteOne();
    return res.status(200).json({ message: "Note deleted successfully" });
}
catch(e){
    console.error("Error deleting note:", e);
        return res.status(500).json({ message: "Internal server error" });
}
});
noteCreate.get('/test-middleware', authcheck, (req, res) => {
    res.json({ message: "Middleware is working!", userId: req.user });
});



module.exports = noteCreate;
