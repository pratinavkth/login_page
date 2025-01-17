const express = require('express');
const authcheck = require('../middelewares/authcheck');
const Expense = require('../models/expense_model');
const User = require('../models/user');
const expenseRouter = express.Router();

expenseRouter.post('/api/createexpense',authcheck,async(req,res)=>{
    try{
        const {description,category, amount} = req.body;
        const userId = req.user;
        console.log("expense router intercepted")
        if(!userId){
            console.log("Id is not found");
        }
        let expnese = new Expense({
            amount,
            description,
            category,
            userId,
            date,
        });
        console.log(expnese);
        expnese = await expnese.save();
        const userexpense = await User.findById(userId);
        console.log(userexpense);
        if(!userexpense){
            res.status(400).send({message:"user not found"});
        }
        userexpense.expenses.push(expnese._id);
        await userexpense.save();
        return res.status(201).json({ message: "Expense created successfully", expense: expnese });
    }
    catch(err){
        console.error(err);
    }
});

expenseRouter.put('/api/updateexpense',authcheck,async(req,res)=>{
    try{
        const{description,category,amount,expenseId,date}= req.body;
        if(!expenseId){
            res.status(400).send({message:"id is not found"});

        }
        const expense= await Expense.findById({expenseId});
        if(description)expense.description = description;
        if(category)expense.category = category;
        if(amount)expense.amount= amount;
        if(date)expense.date= date;

        await expense.save();
        console.log(expense);

        return res.status(200).send({message:"note updatd sucessfully"});


    }
    catch(e){
        res.status(500).send({e:"Internal server error"});
    }

});

expenseRouter.delete('/api/deleteexpense',authcheck,async(req,res)=>{
    try{
        const expenseId = req.body.expenseId;
        if(!expenseId){
            return res.status(400).send({messa})
        }

    }
    catch(e){
        res.status(500).send({e:"Intenal server error"});
    }
});


module.exports= expenseRouter;