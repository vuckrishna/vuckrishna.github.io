// Basic Setup
var http     = require('http'),
express  = require('express'),
mysql    = require('mysql2')
parser   = require('body-parser');
const path = require('path');


// Database Connection
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password@123",
    database: "nothingappdb"
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

app.use('/assets', express.static(path.join(__dirname, 'assets')));


// get all rows from movie table
app.get('/products', function (req, res) {

 con.query('SELECT * FROM products', function (error, results, fields) {
    if (error) throw error;
    return res.send(results); // send results only
  }); 
});

// get one row from movie table
// app.get('/movie/:id', function (req, res) {
//   var id = req.params.id; 

//   con.query('SELECT * FROM movie WHERE movieid = ?', [id], function (error, results, fields) {
//      if (error) throw error;
//      return res.send(results); // send results only
//    }); 
//  });

// post one ROW into movie table
app.post('/products/add', function (req, res) {
    var response = [];

    var title = req.body.title;
    var price = req.body.price;
    var details = req.body.details;
    var imageurl = req.body.imageurl;


    con.query('INSERT INTO products (title, price, details, imageurl) VALUES (?, ?, ?, ?) ', [title, price, details, imageurl], function (error, results, fields) {
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
// app.delete('/product/delete/:id', function (req, res) {
//   var id = req.params.id; 

//   con.query('DELETE FROM products WHERE productid = ?', [id], function (error, results, fields) {
//      if (error) throw error;
//      return res.send(results); // send results only
//    }); 
//  });

  // delete ONE row by title from movie table
app.delete('/product/delete/:id', function (req, res) {
  var id = req.params.id; 

  con.query('DELETE FROM products WHERE title = ?', [id], function (error, results, fields) {
     if (error) throw error;
     return res.send(results); // send results only
   }); 
 });

 // update one ROW into movie table to change only director value
app.put('/product/updateproduct', function (req, res) {
  var response = [];

  var title = req.body.title;
  var price = req.body.price;
  var details = req.body.details;
  var imageurl = req.body.imageurl;

  con.query('UPDATE products SET price= ?, details= ?, imageurl= ? WHERE title= ?', [price, details, imageurl, title], function (error, results, fields) {
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


 
