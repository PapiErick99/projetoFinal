const mongoose = require("../Mongoose")
const Category = require("../schemas/Category")

module.exports = mongoose.model("Category", Category)