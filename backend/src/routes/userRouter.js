const express = require('express')
const { fetchUser, fetchUsers, addUser, updateUser, deleteUser , loginUser } = require('../controllers/userController')
const { uploadUserProfilePics } = require('../Utils/uploadfile')
const userRouter = express.Router()


userRouter.get('/api/user/:id' , fetchUser)
userRouter.get('/api/user/' , fetchUsers)
userRouter.post('/api/user/login' , loginUser)
userRouter.post('/api/user/add' , uploadUserProfilePics.any() , addUser)
userRouter.put('/api/user/:id' , uploadUserProfilePics.any() , updateUser)
userRouter.delete('/api/user/:id' , deleteUser)

module.exports = userRouter