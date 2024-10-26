const mongoose = require('mongoose');

const newNoteSchema = mongoose.Schema({
    title:{
        type:String,
        
    },
    content:{
        type:String,
    },
    Date:{
        type:Date,
        default:Date.now
    },
    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        // required:true,
    },
})
 
const NewNote = mongoose.model('NewNote',newNoteSchema);
module.exports = NewNote;