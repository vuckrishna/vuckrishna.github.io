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
    database: "breakfastdb"
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
app.use(express.static('images'));



// Create server
http.createServer(app).listen(app.get('port'), function(){
  console.log('Server listening on port ' + app.get('port'));
  });

// Set default route
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/index.html');
});

// get all rows from menu table
app.get('/menu', function (req, res) {

  con.query('SELECT * FROM menu', function (error, results, fields) {
     if (error) throw error;
     return res.send(results); // send results only
   }); 
 });
 