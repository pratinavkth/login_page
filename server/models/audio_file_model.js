const mongoose =require('mongoose');

const AudioExpense = mongoose.Schema({
    fileName:{
        type:String,
        required:true,
    },
    filePath:{
        type:String,
        required:true,
    },
    uplodedAt:{
        type:Date,
        default:Date.now,
    },
    duration:{
        type:Number,
    },
    format:{
        type:String,
    },


    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true,
    }

});

const Audio = mongoose.model('Audio',AudioExpense);
module.exports=Audio;