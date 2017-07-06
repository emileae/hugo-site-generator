const express = require('express');
const app = express();

// TODO
// post token and project ID to handler adn adjust exec/deploy statement accordingly
// add static site builder code, navigate folders and then deploy

var shell = require('shelljs');

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.get('/test_shell', (req, res)=>{
  console.log("test shelljs");
  // shell.exec('firebase -help', function(code, stdout, stderr) {
  //   console.log('Exit code:', code);
  //   console.log('Program output:', stdout);
  //   console.log('Program stderr:', stderr);
  // });
  shell.exec('ls', function(code, stdout, stderr) {
    console.log('Exit code:', code);
    console.log('Program output:', stdout);
    console.log('Program stderr:', stderr);
  });

  console.log("-----------");

  shell.exec('hugo version', function(code, stdout, stderr) {
    console.log('Exit code:', code);
    console.log('Program output:', stdout);
    console.log('Program stderr:', stderr);
  });
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
