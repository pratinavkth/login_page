const express = require('express');
const multer = require('multer');
const { MongoClient, GridFSBucket,ObjectId } = require('mongodb');
const bodypareser = require('body-parser');
const dotenv = require('dotenv')
const fs = require('fs');
const path = require('path')
const User = require('../models/user');
const Audio =  require('../models/audio_file_model');
const authcheck = require('../middelewares/authcheck');

dotenv.config();
const AudioRouter = express.Router();

const Storage = multer.memoryStorage();
const upload = multer({Storage});

let bucket;
const Dbname = "audioDB";

const mongoUri= process.env.MOONGODBURL;
MongoClient.connect(mongoUri)
.then((client)=>{
    const db = client.db(Dbname);
    bucket = new GridFSBucket(db,{bucketName:"audioFiles"});
    console.log('Connected to MongoDb and initalized gridfs storage');

}).catch((err)=>console.error('MongoDB connection error :',err));

      

AudioRouter.post('/api/audiorecord',authcheck,upload.single('audio'),async(req,res)=>{
    try{
        if(!req.file){
            return res.status(400).send({error:'No file is uploaded'});
        }

        const uploadStream = bucket.openUploadStream(req.file.originalname,{
            contentType:req.file.mimetype,
        });
        uploadStream.end(req.file.buffer);

        uploadStream.on('finish', () => {
            res.status(200).send({
                message: 'Audio uploaded successfully',
                fileId: uploadStream.id,
            });
        });

        uploadStream.on('error', (err) => {
            console.error('Upload error:', err);
            res.status(500).send({ error: 'Failed to upload audio' });
        });



    }
    catch(e){
        res.status(500).send({e:"Internal server error"});
    }
});

module.exports = AudioRouter;

