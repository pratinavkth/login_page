const mongoose = require('mongoose');

const expenseSchema = mongoose.Schema({
    amount:{
        type:Number,
        required:true,
    },
    description:{
        type:String,

    },
    category:{
        type:String,
        required:true,
    },
    date:{
        type:Date,
        // default:Date.now,
    },
    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        // required:true,
    },
});

const Expense = mongoose.model('Expense',expenseSchema);
module.exports=Expense;