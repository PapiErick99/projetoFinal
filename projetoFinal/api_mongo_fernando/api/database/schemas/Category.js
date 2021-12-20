const {Schema} = require("mongoose")

const Category = new Schema({
    name:{
        type:String,
        required:true
    }
})

module.exports = Category