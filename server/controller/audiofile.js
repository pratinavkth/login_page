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
const Dbname = "test";

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
        const userId = req.user;
        console.log(userId);

        const uploadStream = bucket.openUploadStream(req.file.originalname,{
            contentType:req.file.mimetype,
            metadata:{
            userId:userId,
            }
        });
        uploadStream.end(req.file.buffer);
        

        uploadStream.on('finish',async () =>{
            try{
                let newAudio = new Audio({
                    fileName:req.file.originalname,
                    filePath:`test.audioFiles/${uploadStream.id}`,
                    uplaodedAt:new Date(),
                    format:req.file.mimetype,
                    userId:userId,


                });
                newAudio = await newAudio.save();
                res.status(200).send({
                message: 'Audio uploaded successfully',
                
                userId:userId,
                fileId: uploadStream.id,
               
            });
        }
        catch(err){
            res.status(500).send({err:"internal error"});
        }
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


AudioRouter.get('/api/getaudio',authcheck,async(req,res)=>{
    try{
        const fileId = new ObjectId(req.headers['file-id']);
        const downloadStream = bucket.openDownloadStream(fileId);

        res.set('Content-Type', 'audio/mpeg');

        downloadStream.pipe(res);
        // console.log(res);

        downloadStream.on('error', (err) => {
            console.error('Error retrieving audio:', err);
            res.status(404).send({ error: 'Audio not found' });
        });

    }
    catch(e){
        console.error(e);
        res.status(500).send({e:'failed to download file'})
    }
})

AudioRouter.post('/api/allaudios', authcheck,async(req,res)=>{
    try{
        const userId = req.user;
        console.log(userId);
        if(!userId){
            return res.status(400).send({ message: 'User ID is required' });
        }
        const files = await bucket.find({'metadata.userId':userId}).toArray();
        if(!files.length){
                return res.status(400).send({message:'no Audio found with this user id'});
            }

            res.status(200).send({
                message:"Audio is fetched",
                files:files.map((file)=>({
                    id:file._id,
                    fileName:file.filename,
                    uplaodedAt:file.uplaodedDate,
                    contentType:file.contentType,
                })
            )
            })

    }
    catch(e){
        console.error(e);
        res.status(500).send({ error: 'Failed to fetch audio files' });

    }
})

AudioRouter.delete('/api/audiodelete',authcheck,async(req,res)=>{
    try {
        const fileId = req.body.fileId;
        if(!fileId){
           return res.status(400).send({message:"user id does not found"});
        }

        // console.log("hi ",Audio.findById(fileId));
        // deleteNoteid = await 
       const deleteAudio = await Audio.findById(fileId);
        if(!deleteAudio){
            return res.status(400).send({message:"Audio id not found"});
        }
        await deleteAudio.deleteOne();
        return res.status(200).json({ message: "Audi deleted successfully" });
    }
    catch(e){
        console.log(e);
        return res.status(500).send({e:"Internal server error"});
    }
})


module.exports = AudioRouter;

