const express = require('express');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// INTENTIONALLY WEAK: fixed session secret, sameSite not set, no CSRF middleware.
// This is what makes the CSRF routes exploitable cross-site.
app.use(
  session({
    secret: 'vuln-app-demo-secret',
    resave: false,
    saveUninitialized: true,
    cookie: { httpOnly: true },
  })
);

app.use((req, res, next) => {
  res.locals.user = req.session.user || null;
  next();
});

app.use('/', require('./routes/home'));
app.use('/', require('./routes/auth'));
app.use('/', require('./routes/sqli'));
app.use('/', require('./routes/xss'));
app.use('/', require('./routes/profile'));
app.use('/', require('./routes/idor'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`vuln-app listening on http://localhost:${PORT}`);
});
