const express = require('express');
const body_parser = require('body-parser');
const userRouts = require('./routes/userRouts');
const predictionRouts = require('./routes/predictionRouts');

const app = express();

app.use(body_parser.urlencoded({ extended: false }));
app.use(body_parser.json());

app.use('/api/user', userRouts);
app.use('/api/chd_prediction', predictionRouts);

module.exports = app;
