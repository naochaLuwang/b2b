const express = require('express');
const mongoose = require('mongoose');

const authRouter = require('./routes/auth')
const adminRouter = require('./routes/admin')
const productRouter = require('./routes/product')
const userRouter = require('./routes/user')

const DB = 'mongodb+srv://naocha:autodesk234@cluster0.w8bos.mongodb.net/?retryWrites=true&w=majority'



const PORT = 3000;

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
//connections 

mongoose.connect(DB).then(() => {
    console.log('Connection successful');
}).catch((err) => {
    console.log(err);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});