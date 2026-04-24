const express = require('express');
const router = express.Router();
const { rawAll, rawGet } = require('../db');

// VULN: UNION-based SQL injection.
// The `q` parameter is concatenated directly into a SELECT. The column list
// (id, author, body) lets an attacker UNION SELECT arbitrary rows.
// Exploit:
//   /search?q=zzz' UNION SELECT id, username, password FROM users --
router.get('/search', async (req, res) => {
  const q = req.query.q || '';
  const sql =
    "SELECT id, author, body FROM messages WHERE body LIKE '%" + q + "%'";
  let results = [];
  let error = null;
  if (req.query.q !== undefined) {
    try {
      results = await rawAll(sql);
    } catch (e) {
      error = e.message;
    }
  }
  res.render('search', { q, sql, results, error });
});

// VULN: Boolean-based blind SQL injection.
// Returns different text depending on whether the injected SQL is truthy.
// Exploit (extract admin password one char at a time):
//   /account/check?name=admin' AND substr(password,1,1)='a' --
router.get('/account/check', async (req, res) => {
  const name = req.query.name || '';
  const sql =
    "SELECT id FROM users WHERE username = '" + name + "'";
  let message;
  try {
    const row = await rawGet(sql);
    message = row ? 'Account exists.' : 'No such account.';
  } catch (e) {
    message = 'Query error: ' + e.message;
  }
  res.render('blind', { name, sql, message });
});

module.exports = router;
