const dbConn = require('../dbConfig');

const Prediction = function (prediction) {
  this.date = prediction.date;
  this.userID = prediction.userID;
  this.sex = prediction.sex;
  this.age = prediction.age;
  this.cigsPerDay = prediction.cigsPerDay;
  this.bpMeds = prediction.bpMeds;
  this.prevalentHyp = prediction.prevalentHyp;
  this.totChol = prediction.totChol;
  this.sys_BP = prediction.sys_BP;
  this.dia_BP = prediction.dia_BP;
  this.BMI = prediction.BMI;
  this.heartRate = prediction.heartRate;
  this.glucose = prediction.glucose;
  this.result = prediction.result;
};

Prediction.save = (prediction, res) => {
  dbConn.query('INSERT INTO prediction SET ?', [prediction], (err, dbRes) => {
    if (err) {
      res(null, err);
    } else {
      res(null, dbRes);
    }
  });
};

module.exports = Prediction;
