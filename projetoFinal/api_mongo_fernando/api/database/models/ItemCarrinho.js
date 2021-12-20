const mongoose = require("../Mongoose")
const ItemCarrinho = require("../schemas/ItemCarrinho")

module.exports = mongoose.model("ItemCarrinho", ItemCarrinho)