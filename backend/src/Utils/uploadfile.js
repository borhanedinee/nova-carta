const multer = require('multer');

const productImagesStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        console.log('Destination function triggered');
        cb(null, './uploads/products'); // Adjusted destination path
    },
    filename: function (req, file, cb) {
        console.log(file.originalname);
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        console.log('Filename function triggered');
        cb(null, file.fieldname + '-' + uniqueSuffix + 'filee' + file.originalname); // Fixed callback syntax
    }
});

const userProfilePictureStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        console.log('Destination function triggered');
        cb(null, './uploads/pfps/users'); // Adjusted destination path
    },
    filename: function (req, file, cb) {
        console.log(file.originalname);
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        console.log('Filename function triggered');
        cb(null, file.fieldname + '-' + uniqueSuffix + 'filee' + file.originalname); // Fixed callback syntax
    }
});

const adminProfilePictureStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/pfps/admins/'); // Adjusted destination path
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);

        cb(null, file.fieldname + '-' + uniqueSuffix + 'filee' + file.originalname); // Fixed callback syntax
    }
});

const uploadproducts = multer({ storage: productImagesStorage });
const uploadUserProfilePics = multer({ storage: userProfilePictureStorage });
const uploadAdminProfilePics = multer({ storage: adminProfilePictureStorage });

module.exports = {uploadUserProfilePics, uploadproducts , uploadAdminProfilePics};
