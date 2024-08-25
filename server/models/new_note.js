const mongoose = require('mongoose');

const newNoteSchema = mongoose.Schema({
    title:{
        type:String,
    },
    content:{
        type:String,
    },
})
 
const NewNote = mongoose.model('NewNote',newNoteSchema);
module.exports = NewNote;