const errorHandler = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    console.log(req.url);
    console.log(err.message);

    res.status(err.statusCode).json({
        statusCode: err.statusCode,
        url : req.url,
        message: err.message || 'fail',
        stack: err.stack || 'unkown error',
    })
}

module.exports = errorHandler 