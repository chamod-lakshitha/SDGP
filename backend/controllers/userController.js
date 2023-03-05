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
