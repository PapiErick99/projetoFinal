const {Schema} = require("../Mongoose")

const Product = new Schema({
    name: {
        type:String,
        required:true
    },
    quantity:{
        type:Number,
        required:true
    },
    category: {
        type:Schema.Types.ObjectId,
        ref:"Category",
        required:true
    },
    price:{
        type:Number,
        required:true
    }
})

module.exports = Product