const mongoose = require('mongoose');
const { link } = require('../controller/expense');

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
    ImageUrl:{
        type:String,
        default:null,
    },
    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        // required:true,
    },
})
 
const NewNote = mongoose.model('NewNote',newNoteSchema);
module.exports = NewNote;