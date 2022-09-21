// Basic Setup
var http     = require('http'),
express  = require('express'),
mysql    = require('mysql')
parser   = require('body-parser');

// Database Connection
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "fooddb"
  });

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

// Setup express
var app = express();
app.use(parser.json());
app.use(parser.urlencoded({ extended: true }));
app.set('port', process.env.PORT || 5000);

// Create server
http.createServer(app).listen(app.get('port'), function(){
  console.log('Server listening on port ' + app.get('port'));
  });

// Set default route
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/index.html');
});

// get all rows from MYPARTS table
app.get('/myusername', function (req, res) {

 con.query('SELECT * FROM user1', function (error, results, fields) {
    if (error) throw error;
    return res.send(results); // send results only
  }); 
});

// get all rows from MYPARTS table
app.get('/myproducts', function (req, res) {
  
   con.query('SELECT * FROM products', function (error, results, fields) {
      if (error) throw error;
      return res.send(results); // send results only
    }); 
  });

// post one ROW into movie table
app.post('/signup/add', function (req, res) {
  var response = [];

  var Firstname = req.body.Firstname;
  var Lastname = req.body.Lastname;
  var Emailaddress = req.body.Emailaddress;  
  var Password1 = req.body.Password1;

  con.query('INSERT INTO signup (Firstname, Lastname, Emailaddress, Password1) VALUES (?, ?, ?, ?) ', [Firstname, Lastname,Emailaddress,Password1], function (error, results, fields) {
     if (error) throw error;
     if (results.affectedRows != 0) {
        response.push({'result' : 'success'});
        return res.send(response);
    } else 
    {
        response.push({'result' : 'failure'});
        return res.send(response);
    }
   });
 });

 // delete ONE row by id from movie table
app.delete('/signup/delete/:Emailaddress', function (req, res) {
  var Emailaddress = req.params.Emailaddress; 

  con.query('DELETE FROM signup WHERE Emailaddress = ?', [Emailaddress], function (error, results, fields) {
     if (error) throw error;
     return res.send(results); // send results only
   }); 
 });

 // update one ROW into movie table to change only director value
app.put('/signup/updatePassword1', function (req, res) {
  var response = [];

   // assume title is unique
  var Emailaddress = req.body.Emailaddress;
  var Password1 = req.body.Password1;

  con.query('UPDATE signup SET Password1= ? WHERE Emailaddress= ?', [Emailaddress,Password1], function (error, results, fields) {
     if (error) throw error;
     if (results.affectedRows != 0) {
        response.push({'result' : 'success'});
        return res.send(response);
    } else 
    {
        response.push({'result' : 'failure'});
        return res.send(response);
    }
   });
 });



