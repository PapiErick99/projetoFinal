const UserModel = require("../database/models/User")

module.exports = [
    {
        method:"POST",
        path:"/api/users",
        handler:async (request, h) => {
            try {
                const resp = await UserModel.create(request.payload)
                if(resp !== null){
                    return h.response(resp._id).code(201)
                }else {
                    return h.response("Erro ao criar usuario").code(500)
                }
            } catch (error) {
                return h.response(error).code(500)
            }
        }
    },
    {
        method:"POST",
        path:"/api/users/auth",
        handler:async (request, h) => {
            try {
                const resp = await UserModel.findOne({email:request.payload.email}).exec()
                if(resp != null){
                    if(resp.password === request.payload.password){
                        return h.response(resp._id).code(200)
                    }else {
                        return h.response("Não autorizado").code(401)
                    }
                }else {
                    return h.response("Usuário não encontrado").code(404)
                }
            } catch (error) {
                return h.response("Erro ao logar").code(500)
            }
        }
    },
]
