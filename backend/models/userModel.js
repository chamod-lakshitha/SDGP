const dbConn = require('../dbConfig');

const User = function (user) {
  this.name = user.name;
  this.email = user.email;
  this.password = user.password;
};

User.register = (user, res) => {
    dbConn.query(
      'SELECT id, password FROM user_credentials WHERE email = ?',
      [user.email],
      (err, dbRes) => {
        if ((null, err)) {
          res(err);
        } else {
          if (dbRes.length == 0) {
            dbConn.query(
              'INSERT INTO user_credentials SET ?',
              [user],
              (err, dbRes) => {
                if (err) {
                  res(null, err);
                } else {
                  res(null, dbRes);
                }
            }
          );
        } else {
          res(null, 'registered');
        }
      }
    }
  );
};