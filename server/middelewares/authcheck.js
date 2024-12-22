
const jwt = require('jsonwebtoken');
// const User = require('')

const authcheck = async (req,res,next)=>{
    try {
        console.log("Authcheck Intercepted");
        const token = req.header('x-auth-token');
        console.log("Token:", token);
        
        if(!token){
            return res.status(401).json({message:"No token , authorization denied"});
        }
        const verified = jwt.verify(token,"passwordkey");
        
        if(!verified){
            return res.status(401).json({message:"Token verification failed, authorization denied"});
        }
        req.user = verified.id;
        req.token = token;
        console.log("Token:", token);
        console.log("Verified ID:", verified.id);
        

        next();
        

    } catch (e) {
        res.status(500).json({error:e.message});
    }
}


module.exports = authcheck;