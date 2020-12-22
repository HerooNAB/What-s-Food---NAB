const mongoose = require('mongoose')
const BagSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    item: {
        type: String,
        required: true
    },
},
{ timestamps: true }) //??

const Bag = mongoose.model("Bag", BagSchema);

module.exports = Bag