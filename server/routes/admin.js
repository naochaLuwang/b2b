const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
const User = require("../models/user");

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name,  quantity, price, category } = req.body;
    let product = new Product({
      name,
      
      
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Edit product

adminRouter.post("/admin/edit-product", admin, async (req, res) => {
  try {
    const { id, name, quantity, price, category } = req.body;
    let product = await Product.findById(id);
    product.name = name;
    product.quantity = quantity
    product.price = price
    product.category = category

    product = await product.save()
    res.json(product);

    
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

// Get all your products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//get all users

adminRouter.get("/admin/get-users", admin, async (req, res) => {
  try {
    const users = await User.find({type: "user"});
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
    
  }
})

// delete users

adminRouter.post('/admin/users/delete-user', admin, async (req, res) => {
  try {
    const { id } = req.body;
    let user = await User.findByIdAndDelete(id);
    res.json(user);
    
  } catch (error) {
    res.status(500).json({ error: error.message });
    
  }
})

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = adminRouter;