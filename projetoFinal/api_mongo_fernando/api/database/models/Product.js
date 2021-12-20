const mongoose = require("../Mongoose")
const Product = require("../schemas/Product")

module.exports = mongoose.model("Product", Product)