const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require('../models/user'); 
const authController = express.Router();

authController.post('/api/signup',async (req,res)=>{
    try {
        console.log("Request Intercepted");
        const{email,password,comfirmpassword}= req.body;

        console.log(req.body);

        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({message:"User already exists"});
        }
        hashedPassword = await bcrypt.hash(password,7);
        let user = new User({
            
            email,
            password:hashedPassword,
            confirmpassword:hashedPassword,
        });
        user = await user.save();
        res.json(user);

        
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

authController.post('/api/signin',async (req,res)=>{
    try {
        const{email,password}= req.body;
        console.log(email);
        console.log(password);
        const emailNotExists = await User.findOne({email})
        if(!emailNotExists){
            return res.status(400).json({message:"User does not exist"});
        }
        const InvalidPassword = await bcrypt.compare(password,emailNotExists.password);
        if(!InvalidPassword){
            return res.status(400).json({message:"Invalid Password"});
        }
        const token = jwt.sign({id:emailNotExists._id},"passwordkey");
        console.log(token);
        res.json({token,user:{...emailNotExists._doc}});
        // id:emailNotExists._id,email:emailNotExists.email,
        // console.log(emailNotExists);
        
    } catch (e) {
        console.error(e);
        res.status(500).json({error:e.message});
    }
});
 


authController.post('/tokenisvalid',async (req,res)=>{
    try {
        const token = req.header('x-auth-token');
        if (!token) {
            return res.status(401).json({ msg: "No authentication token, access denied." });
        }
        const verified =jwt.verify(token,"passwordkey");
        if(!verified){
            console.log("Token verification failed.");
            return res.json(false);
        }

        console.log("Token Verified: ", verified);  
        
        const user = await User.findById(verified.id);
        // await User.ObjectId(verified.id);
        console.log("User found: ", user);
        if(!user){
            console.log("No user found for this ID.");
            return res.json(false);
        }
        return res.json(true);


    } catch (e) {
        console.error(e);
        res.status(500).json({error:e.message});
    }

});

module.exports = authController;
