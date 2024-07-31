const express = require('express');
const bycrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const authcheck = require('../middelewares/authcheck');

const authController = express.Router();

authController.post('/register',async (req,res)=>{
    try {
        const{email,password,comfirmpassword}= req.body;

        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({message:"User already exists"});
        }
        hashedPassword = await bycrypt.hash(password,7);
        const user = new User({
            email,
            password:hashedPassword,
            comfirmpassword:hashedPassword,
        });
        user = await user.save();
        res.json(user);

        
    } catch (e) {
        res.status(500).json({error:e.message});
    }
})

authController.post('/login',async (req,res)=>{
    try {
        const emailNotExists = await User.findOne({email})
        if(!emailNotExists){
            return res.status(400).json({message:"User does not exist"});
        }
        const InvalidPassword = await bycrypt.compare(password,emailNotExists.password);
        if(!InvalidPassword){
            return res.status(400).json({message:"Invalid Password"});
        }
        
    } catch (e) {
        
    }
})

authController.post('/tokenisvalid',async (req,res)=>{
    try {
        const token = req.header('x-auth-token');
        if(!token){
            return res.json(false);
        }
        const verified =jwt.verify(token,"passwordkey");
        if(!verified){
            return res.json(false);
        }
        const user = await User.findbById(verified.id);
        if(!user)
            return res.json(false);
        return res.json(true);


    } catch (e) {
        
    }

})

authController.get('/',authcheck, async(req,res)=>{
  const user = await User.findById(req.user);
  res.json({
        email:user.email,
        id:user._id,
  })  
})

module.exports = authController;