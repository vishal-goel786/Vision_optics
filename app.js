const express = require('express');
const exphbs = require('express-handlebars');
const cookieParser = require('cookie-parser');
var session = require('express-session');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const crypto = require('crypto');
const path = require("path");
const multer = require("multer")
//const helpers = require('./helpers/handlebar');
const Razorpay = require('razorpay');
const handlebarsHelpers = require('./helpers/handlebar');
var dateFormat = require('dateformat');
const app = express();
const authTokens = {};
let data = [];
// that make use of the session.
//connection 
const instance = new Razorpay({
  key_id: 'rzp_test_4Ul7qSZnvkrOzc',
  key_secret: 'jlOs1tEEnlJ9ZNtUg5n6yl2w'
});
var storage =   multer.diskStorage({  
  destination: function (req, file, callback) {  
    callback(null, './public/uploads');  
  },  
  filename: function (req, file, callback) {  
    callback(null, file.originalname);  
  }  
});  
var upload = multer({ storage : storage}).single('p_image');  
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'vision_optics'
  });

//Set static folder
app.use(express.static(path.join(__dirname, "public")));

const getHashedPassword = (password) => {
    const sha256 = crypto.createHash('sha256');
    const hash = sha256.update(password).digest('base64');
    return hash;
}

const generateAuthToken = () => {
    return crypto.randomBytes(30).toString('hex');
}

// to support URL-encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

app.use(cookieParser());

app.use((req, res, next) => {
    const authToken = req.cookies['AuthToken'];
    req.user = authTokens[authToken];
    next();
});

const helpers = {
  xif: function (expression, options) {
    return helpers["x"].apply(this, [expression, options]) 
      ? options.fn(this)
      : options.inverse(this);
  },
  x: function (expression, options) {
      var result;
      var context = this;
      with(context) {
          result = (function() {
              try {
                  return eval(expression);
              } catch (e) {
                  console.warn('•Expression: {{x \'' + expression + '\'}}\n•JS-Error: ', e, '\n•Context: ', context);
              }
          }).call(context); // to make eval's lexical this=context
      }
      return result;
  }
};
app.engine('hbs', exphbs({
  extname: '.hbs',
  helpers
}));
app.set('view engine', 'hbs');

app.get('/', (req, res) => {
    res.render('home');
});
app.get('/contect-us', (req, res) => {
    res.render('contac_us');
});

app.get('/logout',(req,res)=>{
    data=[];
    res.redirect('/login');
})
app.get('/login', (req, res) => {
    if(data["user_name"] != null)
    {
        res.redirect("/customers");
    }else{
        res.render('login');
    } 
});
app.post('/login', (req, res) => {
    const { email, password } = req.body;
   // const hashedPassword = getHashedPassword(password);
    let errors = [];
    if (!email) {
      errors.push("Enter your email");
    }
    if (!password) {
      errors.push("Enter your password");
    }
    if (errors.length > 0) {
      res.render("login", { message : errors, messageClass: 'alert-danger',email });
    } else{
        connection.query('SELECT * FROM admin WHERE username = ? AND password = MD5(?)', [email, password], function (err, result, fields) {
            if (err) {
                throw err;
                res.json({ status: "error", message: "An error has occurred. Please try again later" });
            } else {
                if (result.length == 0) {     
                    errors.push("Wrong Username and Password");
                    res.render("login", { message : errors, messageClass: 'alert-danger', email });
                } else {
                    
                    data["uid"] = result[0].id;
                    data["user_name"] = result[0].username;
                    data["status"] = result[0].status;
                    console.log(data);
                    res.redirect("/customers");
                }
            }

        });
    }
});
app.get('/customers', function(req, res, next) {
    if (data["user_name"] == null) {
        res.redirect("/login");
      }else{
        var query = 'select * from employees';
        connection.query(query, function(err, rows, fields) {
          if (err) throw err;
          //console.log(rows);
          res.render('customer_list', { title: 'Customers', customers: rows});
        })
      }
  });

  /*update product*/
    app.get('/edit/:id', function(req, res, next) {
        var id = req.params.id;
        var sql_2 = `SELECT * FROM product`;
        var sql = `SELECT * FROM employees WHERE customer_id=${id}`;
        connection.query(sql_2, function(err, product) {
          if (err) throw err; //you should use this for error handling when in a development environment
          console.log(product);
        connection.query(sql, function(err, rows) {
          if (err) throw err;
          console.log(rows);
            res.render('editform', {title: 'Edit Customer', customers: rows[0] , products:product});
        });
      });
    });
  //edit
  app.post('/edit/:id', function(req, res, next) {
    var first_name = req.body.firstname;
    var glass_name = req.body.glass_name;
    var lance_number = req.body.lance_number;
    var email = req.body.email;
    var phone_number = req.body.phone_number;
    var quntity = req.body.quntity;
    var price = req.body.price;
    var id = req.params.id;
    var sql = `UPDATE employees SET firstname = "${first_name}",glass_name="${glass_name}",lance_number="${lance_number}",email="${email}",phone_number="${phone_number}",quntity="${quntity}",price="${price}" where customer_id=${id}`;
    connection.query(sql, function(err, result) {
      if (err) throw err;
      console.log('record updated!');
      res.redirect('/customers');
    });
  });



app.get('/customer_add', (req, res) => {
    if(data["user_name"] != null)
    {
      var sql = `SELECT * FROM product`;
      connection.query(sql, function(err, rows, fields) {
          res.render('customer_add', {title: 'Add customer', products: rows});
      });
    }else{
        res.render('login');
    } 
    
});

app.post('/customer_add', (req, res) => {
    const { firstname, glass_name, lance_number, email, phone_number,quntity,price } = req.body;
    var errors = [];
    if (!firstname) {
        errors.push("Enter your name");
      }
      if (!glass_name) {
        errors.push("Enter Glass Name");
      }
      if (!lance_number) {
        errors.push("Enter Lance Number");
      }
      if (!email) {
        errors.push("Enter Email Addresss");
      }
      if (!phone_number) {
        errors.push("Enter Phone Number");
      }
      if (!quntity) {
        errors.push("Enter Lance Quntity");
      }
      if (!price) {
        errors.push("Enter Lance Price");
      }
      if (errors.length > 0)
      {
        res.render("customer_add", { message : errors, messageClass: 'alert-danger',firstname, glass_name, lance_number,email,phone_number,quntity,price });
      }else{
        var sql = `SELECT * FROM employees WHERE email="${email}"`;
        connection.query(sql, function(err, rows, fields) {
            console.log(rows)
           if(rows.length == 0)
           {
            var sql = `INSERT INTO employees(firstname,glass_name,lance_number,email,phone_number,quntity,price) VALUES ("${firstname}", "${glass_name}", "${lance_number}","${email}","${phone_number}","${quntity}","${price}")`;
            connection.query(sql, function(err, result) {
              if (err) throw err;
              console.log('record inserted');
              res.redirect('/customers');
            }); 
           }else{
                errors.push("Customer already Exits");
                res.render("customer_add", { message : errors, messageClass: 'alert-danger',firstname, glass_name, lance_number,email,phone_number,quntity,price });
           }
        });
      }
});
/*delete product*/
app.get('/delete/:id', function(req, res){
    var id = req.params.id;
    console.log(id);
    var sql = `DELETE FROM employees WHERE customer_id=${id}`;
  
    connection.query(sql, function(err, result) {
      if (err) throw err;
      console.log('record deleted!');
      res.redirect('/customers');
    });
  });

app.get('/product_add', (req, res) => {
    if(data["user_name"] != null)
    {
      var sql = `SELECT * FROM size`;
        connection.query(sql, function(err, rows, fields) {
            res.render('product_add', {title: 'Add Product', products: rows});
        });
    }else{
        res.render('login');
    }  
});
app.post('/product_add', (req, res) => {
   upload(req,res,function(err) {  
    const { p_name, price,lance_number, size, description,p_image } = req.body;
    const start = Date.now();
    var errors = [];
    if(err) {  
      errors.push("uploade valid file");
    }  
    if (!p_name) {
        errors.push("Enter your Product Name");
      }
      if (!price) {
        errors.push("Enter Product Price");
      }
      if (!lance_number) {
        errors.push("Enter Lance Number");
      }
      if (!size) {
        errors.push("select size");
      }
      if (!description) {
        errors.push("Description felid is required");
      }
      if (errors.length > 0)
      {
        res.render("product_add", { message : errors, messageClass: 'alert-danger',p_name, price, lance_number,size,description});
      }else{
          
            var sql = `INSERT INTO product(name,price,description,image,size,lance_number,added_date,status) VALUES ("${p_name}", "${price}","${description}", "${req.file.originalname}", "${size}", "${lance_number}","${start}",'1')`;
            connection.query(sql, function(err, result) {
              if (err) throw err;
              console.log('record inserted');
              res.redirect('/products');
            }); 
          } 
    });
  });
  app.get('/products', function(req, res, next) {
    if (data["user_name"] == null) {
        res.redirect("/login");
      }else{
        var query = 'select pd.*,sz.size,sz.id as sid from product as pd left join size as sz on pd.size = sz.id';
        connection.query(query, function(err, rows, fields) {
          if (err) throw err;
          console.log(rows);
          res.render('product_list', { title: 'Products', products: rows});
        })
      }
  });
 /*delete product*/
app.get('/deleteproduct/:id', function(req, res){
  var id = req.params.id;
  console.log(id);
  var sql = `DELETE FROM product WHERE id=${id}`;

  connection.query(sql, function(err, result) {
    if (err) throw err;
    console.log('record deleted!');
    res.redirect('/products');
  });
});
app.get('/buyproduct', function(req, res, next) {
  if (data["user_name"] == null) {
    res.redirect("/login");
  }else{
      var query = 'select pd.*,sz.size,sz.id as sid from product as pd left join size as sz on pd.size = sz.id';
      var sql = 'select * from employees';
      connection.query(sql, function(err, custm, fields) {
        if (err) throw err;
        console.log(custm);
        connection.query(query, function(err, rows, fields) {
          if (err) throw err;
          console.log(rows);
            res.render('buy_product', { title: 'Products', customer: custm, products: rows,key_id: 'rzp_test_wKvqv6FMJGM0fs'});
        });
      });
    }
});
app.get('/success',function(req,res){
  var ck_data = JSON.parse(req.cookies.cookiedata);
  /*{"price":"150","total_price":150,"payment_id":"pay_Glo857m9EfOyD8","quntity":"1","currency":"USD","cust_id":"8","cust_name":"Leslie","cust_email":"lthompson@example.com","cust_phone":"0"}*/
  var p_id = ck_data.product_id;
  var price = ck_data.price;
  var total_price = ck_data.total_price;
  var pay_id = ck_data.payment_id;
  var p_name = ck_data.p_name;
  var description = ck_data.description;
  var image = ck_data.image;
  var quntity = ck_data.quntity;
  var currency = ck_data.currency;
  var cust_id = ck_data.cust_id;
  var cust_name = ck_data.cust_name;
  var cust_email = ck_data.cust_email;
  var cust_phone = ck_data.cust_phone;
  var d_day = ck_data.d_day;
  var day=dateFormat(new Date(), "yyyy-mm-dd h:MM:ss");
  var sql = `SELECT * FROM payment WHERE payment_id="${pay_id}"`;
        connection.query(sql, function(err, rows, fields) {
           if(rows.length == 0)
           {
            var sql = `INSERT INTO payment(cust_id,product_id,cust_name,cust_email,payment_id,d_day,quntity,price,currency,total_price,added_date) VALUES ("${cust_id}", "${p_id}", "${cust_name}","${cust_email}","${pay_id}","${d_day}","${quntity}","${price}","${currency}","${total_price}","${day}")`;
            connection.query(sql, function(err, result) {
              if (err) throw err;
              console.log('record inserted');
              res.render('success.hbs',{p_id,price,total_price,cust_name,cust_email,cust_phone,currency,day,pay_id,quntity,p_name,description,image,d_day});
            }); 
           }else{
               //res.render('success.hbs',{p_id,price,total_price,cust_name,cust_email,cust_phone,currency,day,pay_id,quntity,p_name,description,image,d_day});
               res.redirect('/');
           }
        });
  
});
app.post('/buyproduct', function(req, res, next) {
  console.log(res.body);
});

app.get('/protected', (req, res) => {
    if (req.user) {
        res.render('protected');
    } else {
        res.render('login', {
            message: 'Please login to continue',
            messageClass: 'alert-danger'
        });
    }
});

app.get('/email/template', (req, res, next) => {
  MailConfig.ViewOption(gmailTransport,hbs);
  let HelperOptions = {
    from: '"Tariqul islam" <tariqul.islam.rony@gmail.com>',
    to: 'tariqul@itconquest.com',
    subject: 'Hellow world!',
    template: 'test',
    context: {
      name:"tariqul_islam",
      email: "tariqul.islam.rony@gmail.com",
      address: "52, Kadamtola Shubag dhaka"
    }
  };
  gmailTransport.sendMail(HelperOptions, (error,info) => {
    if(error) {
      console.log(error);
      res.json(error);
    }
    console.log("email is send");
    console.log(info);
    res.json(info)
  });
});

// app.get('/email/smtp/template', (req, res, next) => {
//   MailConfig.ViewOption(smtpTransport,hbs);
//   let HelperOptions = {
//     from: '"Tariqul islam" <tariqul@falconfitbd.com>',
//     to: 'tariqul.islam.rony@gmail.com',
//     subject: 'Hellow world!',
//     template: 'test',
//     context: {
//       name:"tariqul_islam",
//       email: "tariqul.islam.rony@gmail.com",
//       address: "52, Kadamtola Shubag dhaka"
//     }
//   };
//   smtpTransport.verify((error, success) => {
//       if(error) {
//         res.json({output: 'error', message: error})
//         res.end();
//       } else {
//         smtpTransport.sendMail(HelperOptions, (error,info) => {
//           if(error) {
//             res.json({output: 'error', message: error})
//           }
//           res.json({output: 'success', message: info});
//           res.end();
//         });
//       }
//   })
  
// });

app.listen(8000);