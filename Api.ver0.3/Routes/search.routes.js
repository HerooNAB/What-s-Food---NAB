const express = require('express');
const router = express.Router();
const User = require('../models/User.model');
const Bag = require('../models/Bag.model.js');
require('dotenv').config()

router.get("/searchuser", async (req,res) => {
    const query = "^" + req.query.user + "$";
    console.log(query.toString());
    const fountUser = await User.find({
        name: {$regex: req.query.user, $options: "i"},
    });
    if (!fountUser) return res.status(000).send({message: "khong tim thay"});
    res.status(200).send(fountUser);
});

router.post('/addbag', (req, res) => {
    const {name, item} = req.body
    if (!name || !item) {
        return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" })
    }
    const bag = new Bag({
        name,
        item
    })
    bag.save().then(result => {
            res.json({ Bag: result })
        })
        .catch(err => {
            console.log(err)
        })
})

router.get("/searchbag", async (req,res) => {
    const query = "^" + req.query.item + "$";
    console.log(query.toString());
    const fountItem = await Bag.find({
        item: {$regex: req.query.item , $options: "i"},
    });
    if (!fountItem) return res.status(000).send({message: "khong tim thay"});
    res.status(200).send(fountItem);
});

module.exports = router;