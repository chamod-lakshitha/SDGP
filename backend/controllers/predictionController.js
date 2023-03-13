const { PythonShell } = require('python-shell');
const PredictionModel = require('../models/predictionModel');

exports.predict = (req, res) => {
  console.log('request came');
  const options = {
    args: [
      req.body.sex,
      req.body.age,
      req.body.cigsPerDay,
      req.body.bpMeds,
      req.body.prevalentHyp,
      req.body.totChol,
      req.body.sys_BP,
      req.body.dia_BP,
      req.body.BMI,
      req.body.heartRate,
      req.body.glucose,
    ],
  };
  try {
    PythonShell.run('../backend/prediction.py', options, (error, resolve) => {
      if (error) {
        res.send({ success: false });
      } else {
        req.body = Object.assign(req.body, {
          result: resolve[0][1],
        });
        PredictionModel.save(new PredictionModel(req.body), (err, dbRes) => {
          if (err) {
            res.send({ success: false });
          } else {
            console.log(dbRes);
            res.send({ success: true, value: resolve[0][1] });
          }
        });
      }
    });
  } catch {
    res.send({ success: false });
  }
};

exports.history = (req, res) => {
  PredictionModel.history(req.body.userID, (err, dbRes) => {
    if (err) {
      res.send({ success: false });
    } else {
      console.log(dbRes);
      res.send({ success: true, result: dbRes });
    }
  });
};
