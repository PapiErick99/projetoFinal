const ProductModel = require("../database/models/Product")
const mongoose = require("../database/Mongoose")

module.exports = [
    {
        method:"GET",
        path:"/api/products",
        handler:async (request, h) => {
            try {
                const resp = await ProductModel.find({}).exec()
                return h.response(resp).code(200)
            } catch (error) {
                return h.response().code(500)
            }
        }
    },
    {
        method:"POST",
        path:"/api/products",
        handler:async (request, h) => {
            try {
                let {name, quantity, category, price} = request.payload
                let _category = mongoose.mongo.ObjectId(category)
                const resp = await ProductModel.create({
                    name,
                    quantity,
                    category:_category,
                    price
                })
                return h.response(resp._id).code(201)
            } catch (error) {
                return h.response().code(500)
            }
        }
    }
]