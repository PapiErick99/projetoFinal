const {Schema} = require('mongoose')

const ItemCarrinho = new Schema({
    userId: {
        type:Schema.Types.ObjectId,
        ref:"User",
        required:true
    },
    product: {
        type:String,
        required:true
    },
    price:{
        type:Number,
        required:true
        
    }
})

module.exports = ItemCarrinho