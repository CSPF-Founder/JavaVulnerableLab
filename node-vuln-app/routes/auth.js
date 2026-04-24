const express = require('express');
const router = express.Router();
const { rawGet, run, get } = require('../db');

router.get('/login', (req, res) => {
  res.render('login', { error: null, query: null });
});

// VULN: Classic SQL injection via string concatenation on both fields.
// Exploit: username = admin' -- , password = anything
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const sql =
    "SELECT id, username, role FROM users WHERE username = '" +
    username +
    "' AND password = '" +
    password +
    "'";
  try {
    const row = await rawGet(sql);
    if (!row) return res.render('login', { error: 'Invalid credentials', query: sql });
    req.session.user = row;
    res.redirect('/');
  } catch (e) {
    res.render('login', { error: 'SQL error: ' + e.message, query: sql });
  }
});

router.get('/register', (req, res) => {
  res.render('register', { error: null });
});

router.post('/register', async (req, res) => {
  const { username, password, email } = req.body;
  try {
    await run(
      `INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, 'user')`,
      [username, password, email]
    );
    res.redirect('/login');
  } catch (e) {
    res.render('register', { error: e.message });
  }
});

router.get('/logout', (req, res) => {
  req.session.destroy(() => res.redirect('/'));
});

module.exports = router;
