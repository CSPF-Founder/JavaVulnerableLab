const express = require('express');
const router = express.Router();
const { all, run } = require('../db');

// VULN: Reflected XSS.
// The `greet` query param is rendered raw by the view (<%- greet %>).
// Exploit: /hello?greet=<script>alert(document.cookie)</script>
router.get('/hello', (req, res) => {
  res.render('hello', { greet: req.query.greet || '' });
});

// VULN: Stored XSS.
// /messages lists all messages and renders `body` as raw HTML (<%- body %>).
// Any logged-in user can POST a <script> payload and it fires for every
// visitor who loads the page.
router.get('/messages', async (req, res) => {
  const messages = await all(
    `SELECT id, author, body, created_at FROM messages ORDER BY id DESC`
  );
  res.render('messages', { messages });
});

router.post('/messages', async (req, res) => {
  if (!req.session.user) return res.redirect('/login');
  const body = req.body.body || '';
  await run(`INSERT INTO messages (author, body) VALUES (?, ?)`, [
    req.session.user.username,
    body,
  ]);
  res.redirect('/messages');
});

module.exports = router;
