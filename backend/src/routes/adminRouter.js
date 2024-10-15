const express = require('express');
const { fetchAdmin, fetchAdmins, addAdmin, updateAdmin, deleteAdmin } = require('../controllers/adminController');
const { uploadAdminProfilePics } = require('../Utils/uploadfile');

const adminRouter = express.Router();


//here pass all the url endpoints and corresponding controllers
adminRouter.get('/api/admin/', fetchAdmins);
adminRouter.get('/api/admin/:id', fetchAdmin);
adminRouter.post('/api/admin/add', uploadAdminProfilePics.any() , addAdmin); // here since i am uploading a file or expect the end point to
adminRouter.put('/api/admin/:id', uploadAdminProfilePics.any() , updateAdmin); // recieve data from form-data => im calling the muter middlware
adminRouter.delete('/api/admin/:id', deleteAdmin);

module.exports = adminRouter;