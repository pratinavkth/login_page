const express = require("express");
const NewNote = require('../models/new_note');

const noteCreate = express.Router();

noteCreate.post('/api/note_create',async(req,res)=>{
    try {
        const {title,content} = req.body;
        console.log(req.body);
        let note = new NewNote({
            title,
            content,
        });
        note = await note.save();
        res.json(note);
    } catch (e) {
        express.json({error:e.message});
    }
})

noteCreate.get('/api/note_search', async(req,res)=>{
    try{
        const noteSearch = await NewNote.findOne({title:req.body.title});
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




module.exports = noteCreate;