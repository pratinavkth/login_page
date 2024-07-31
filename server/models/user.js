const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    email:{
        type:String,
        required:true,
        unique:true,
        trim:true,
        validate:{
            validator:(value)=>{
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message:"Please enter a valid email",

        }
    },
    password:{
        type:String,
        required:true,
        validate:{
            validator:(value)=>{
                return value.length>7;
            },
            message:"Password should be atleast 7 charachters long"
        },
    },
    confirmpassword:{
        type:String,
        required:true,
        validate:{
            validator:(value)=>{
                value === this.password;
            }
        }
    }

})

const User = mongoose.model('User',userSchema);
module.exports = User;