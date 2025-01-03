const express = require('express');
const multer = require('multer');
const User = require('../models/user');
const Audio =  require('../models/audio_file_model');
const authcheck = require('../middelewares/authcheck');

const AudioRouter = express.Router();


AudioRouter.post('/api/audiorecord',authcheck,async(req,res)=>{
    try{

    }
    catch(e){
        print(e);
    }
});


