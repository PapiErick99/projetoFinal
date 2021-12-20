const ItemCarrinho = require("../database/models/ItemCarrinho")
const mongoose = require("../database/Mongoose")

module.exports = [
    {
        method:"POST",
        path:"/api/items",
        handler:async (request, h) => {
            try {
                console.log(request.payload)
                let {userId, product, price} = request.payload
                let _userId = mongoose.mongo.ObjectId(userId)
                const resp = await ItemCarrinho.create({
                    userId:_userId, 
                    product,
                    price
                })
                return h.response(resp._id).code(201)
            } catch (error) {
                console.log(error)
                return h.response().code(500)
            }
        }
    },
    {
        method:"GET",
        path:"/api/users/{id}/items",
        handler:async (request, h) => {
            try {
                let {id} = request.params
                const resp = await ItemCarrinho.find({userId:id}).exec()
                return h.response(resp).code(200)
            } catch (error) {
                console.log(error)
                return h.response().code(500)
            }
        }
    },
    {
        method:"DELETE",
        path:"/api/users/{id}/remove-items",
        handler:async(request, h) => {
            try {
                let {id} = request.params
                await ItemCarrinho.deleteMany({userId:id}).exec()
                return h.response().code(204)
            } catch (error) {
                console.log(error)
                return h.response().code(500)
            }
        }
    }
]