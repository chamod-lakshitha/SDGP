const mysql = require('mysql');
require('dotenv').config();

var dbConn;

function handleDisconnect() {
  dbConn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
  });

  dbConn.connect(function (err) {
    if (err) {
      console.log('error when connecting to db:', err);
      setTimeout(handleDisconnect, 2000);
    } else {
      console.log('connected successful');
    }
  });

  dbConn.on('error', function (err) {
    console.log('db error', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      handleDisconnect();
    } else {
      throw err;
    }
  });
}

handleDisconnect();

module.exports = dbConn;

// const mysql = require('mysql');
// require('dotenv').config();

// const dbConn = mysql.createConnection({
//   host: process.env.HOST,
//   user: process.env.USER,
//   password: process.env.PASSWORD,
//   database: process.env.DATABASE,
// });

// dbConn.connect((error) => {
//   if (error) {
//     console.log(error);
//   }
//   console.log('connected successful');
// });

// module.exports = dbConn;
