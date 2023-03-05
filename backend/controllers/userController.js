const bcrypt = require('bcrypt');
const UserModel = require('../models/userModel');

exports.register = async (req, res) => {
  try {
    req.body.password = await bcrypt.hash(req.body.password, 10);
    UserModel.register(new UserModel(req.body), (err, dbRes) => {
      if (err) {
        res.send({ success: false, alreadyRegistered: false });
      } else {
        if (dbRes == 'registered') {
          res.send({ success: true, alreadyRegistered: true });
        } else {
          res.send({ success: true, alreadyRegistered: false });
        }
      }
    });
} catch {
    res.send({ success: false, alreadyRegistered: false });
  }
};

exports.login = async (req, res) => {
    try {
      UserModel.login(req.body.email, async (err, dbRes) => {
        if (err) {
          res.json({ success: false });
        } else {
          if (dbRes.length > 0) {
            if (await bcrypt.compare(req.body.password, dbRes[0].password)) {
              res.json({ success: true, userID: dbRes[0].id });
            } else {
              res.json({ success: false });
            }
          } else {
            res.json({ success: false });
          }
        }
      })
    } catch {
        res.json({ success: false });
      }
    };