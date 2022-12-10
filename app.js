const express = require('express');
const app = express();

app.get('/hello', (req, res) => {
  const RESPONSE = process.env.RESPONSE || "WORLD";
  res.send(`Hello ${RESPONSE}`);
});

const port = process.env.PORT || 8080;
app.listen(port, function() {
  console.log('App running on port ', port);
});