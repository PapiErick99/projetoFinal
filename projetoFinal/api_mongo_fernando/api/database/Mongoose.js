const mongoose = require("mongoose")

mongoose.set("runValidators", true)
mongoose.Promise = global.Promise
mongoose.connect("mongodb+srv://alex:XBmBAQeVXRTmXv5v@cluster0.bows9.gcp.mongodb.net/myFirstDatabase?retryWrites=true&w=majority", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log("Mongo ok"))
.catch(err => console.log(err))

module.exports = mongoose