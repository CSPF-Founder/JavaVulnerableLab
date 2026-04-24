const express = require('express');
const router = express.Router();
const { all, get } = require('../db');

// VULN: IDOR — file download by id with no ownership check.
// Any logged-in user (or even an unauthenticated visitor) can fetch any
// file by id. The UI only links to the current user's files, but id is
// a sequential integer so tampering is trivial.
// Exploit: /file?id=1 reveals admin-notes.txt
router.get('/files', async (req, res) => {
  if (!req.session.user) return res.redirect('/login');
  const mine = await all(
    `SELECT id, filename FROM files WHERE owner_id = ?`,
    [req.session.user.id]
  );
  res.render('files', { mine });
});

router.get('/file', async (req, res) => {
  const id = req.query.id;
  const row = await get(`SELECT filename, contents FROM files WHERE id = ?`, [id]);
  if (!row) return res.status(404).send('Not found');
  res.render('file_view', { file: row });
});

// VULN: IDOR — /user/:id leaks private fields (email) for any user.
// There is no session check at all.
router.get('/user/:id', async (req, res) => {
  const row = await get(
    `SELECT id, username, email, role, bio FROM users WHERE id = ?`,
    [req.params.id]
  );
  if (!row) return res.status(404).send('Not found');
  res.render('user_view', { profile: row });
});

module.exports = router;
