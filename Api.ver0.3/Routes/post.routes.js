const express = require('express')
const router = express.Router()
const mongoose = require('mongoose')
const RequireLogin = require('../middleware/RequireLogin')
const Post = require('../models/Post.model');
require('dotenv').config()
var { cloudinary } = require('../utils/cloudinary.js');
var multer  = require('multer')
var fs = require('fs');
const Food = require('../models/Food.model');

const storage = multer.diskStorage({})

router.post('/createpost',RequireLogin, (req, res) => {
    const {caption, image} = req.body
    if (!caption || !image) {
        return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" })
    }
    const post = new Post({
        image,
        caption,
        postedBy: req.user
    })
    post.save().then(result => {
            res.json({ post: result })
        })
        .catch(err => {
            console.log(err)
        })
})



router.get('/allpost', RequireLogin, (req, res) => {
    Post.find()
        .populate("postedBy", "_id ")
        .populate("comments.postedBy", "_id ")
        .sort('-createdAt')
        .then((posts) => {
            res.json({ posts })
        }).catch(err => {
            console.log(err)
        })

})

router.get('/mypost', RequireLogin, (req, res) => {
    Post.find({ postedBy: req.user._id })
        .populate("PostedBy", "_id name")
        .then(mypost => {
            res.json({ mypost })
        })
        .catch(err => {
            console.log(err)
        })
})

router.put('/like',RequireLogin,(req,res)=>{
    Post.findByIdAndUpdate(req.body.postId,{
        $push:{likes:req.user._id}
    },{
        new:true
    }).exec((err,result)=>{
        if(err){
            return res.status(422).json({error:err})
        }else{
            res.json(result)
        }
    })
})


router.put('/unlike',RequireLogin,(req,res)=>{
    Post.findByIdAndUpdate(req.body.postId,{
        $pull:{likes:req.user._id}
    },{
        new:true
    }).exec((err,result)=>{
        if(err){
            return res.status(422).json({error:err})
        }else{
            res.json(result)
        }
    })
})

router.put('/comment',RequireLogin,(req,res)=>{
    const comment = {
        text:req.body.text,
        postedBy:req.user._id
    }
    Post.findByIdAndUpdate(req.body.postId,{
        $push:{comments:comment}
    },{
        new:true
    })
    .populate("comments.postedBy","_id name")
    .populate("postedBy","_id name")
    .exec((err,result)=>{
        if(err){
            return res.status(422).json({error:err})
        }else{
            res.json(result)
        }
    })
})
router.delete('/deletepost/:postId', RequireLogin, (req, res) => {
    Post.findOne({ _id: req.params.postId })
        .populate("postedBy", "_id")
        .exec((err, post) => {
            if (err || !post) {
                return res.status(422).json({ error: err })
            }
            if (post.postedBy._id.toString() === req.user._id.toString()) {
                post.remove()
                    .then(
                        res.json('Xóa bài thành công!')
                    ).catch(err => {
                        console.log(err)
                    })
            }
        })
})

//add nghia
router.put('/like',RequireLogin, (req, res) =>{
    Post.findByIdAndUpdate(req.body.postId,{
        $push:{likes:req.user._id}
    },{
        new:true
    }).exec((err,result)=>{
        if(err){
            return res.status(422).json({error:err})
        }else{
            res.json(result)
        }
    })
})

router.post('/createfood',RequireLogin, (req, res) => {
    const {name, photo, ingredient, haciendo} = req.body
    if (!name || !photo || !ingredient || !haciendo) {
        return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" })
    }
    const food = new Food({
        photo,
        name,
        ingredient,
        haciendo,
        postedBy: req.user
    })
    food.save().then(result => {
            res.json({ food: result })
        })
        .catch(err => {
            console.log(err)
        })
})

module.exports = router;