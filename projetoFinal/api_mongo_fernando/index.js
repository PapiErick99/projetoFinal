const Hapi = require("@hapi/hapi")
const UserRouter = require("./api/routes/User")
const ProductRouter = require("./api/routes/Product")
const CategoryRouter = require("./api/routes/Category")
const CarrinhoRouter = require("./api/routes/ItemCarrinho")

const server = Hapi.server({
    host:"192.168.0.231",
    port:3000,
    routes:{
        cors:true
    }
})

server.route(ProductRouter)
server.route(UserRouter)
server.route(CategoryRouter)
server.route(CarrinhoRouter)

server.start()
.then(() => console.log("Tudo ok"))
.catch(err => console.log(err))