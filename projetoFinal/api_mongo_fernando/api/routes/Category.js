const CategoryModel = require("../database/models/Category")
const Product = require("../database/models/Product")

module.exports = [
    {
        method:"GET",
        path:"/api/category/{id}/products",
        handler:async (request, h) => {
            try {
                let {id} = request.params
                const resp = await Product.find({category:id}).exec()
                return h.response(resp).code(200)
            } catch (error) {
                return h.response().code(500)
            }
        }
    },
    {
        method:"GET",
        path:"/api/categories",
        handler:async(request, h) => {
            try {
                const resp = await CategoryModel.find({}).exec()
                return h.response(resp).code(200)
            } catch (error) {
                return h.response().code(500)
            }
        }
    }
]