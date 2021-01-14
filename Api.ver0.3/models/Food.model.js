const mongoose = require('mongoose')
const { ObjectId } = mongoose.Schema.Types
const FoodSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    ingredient: {
        type: String,
        required: true
    },
    haciendo: {
        type: String,
        required: true
    },
    photo: {
        type: String,
        required: true
    },
    postedBy: {
        type: ObjectId,
        ref: "User"
    }
},
{ timestamps: true }) //??

const Food = mongoose.model("Food", FoodSchema);

module.exports = Food