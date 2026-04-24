const express = require('express');
const router = express.Router();
const { run, get } = require('../db');

function requireLogin(req, res, next) {
  if (!req.session.user) return res.redirect('/login');
  next();
}

router.get('/profile', requireLogin, async (req, res) => {
  const row = await get(`SELECT id, username, email, role, bio FROM users WHERE id = ?`, [
    req.session.user.id,
  ]);
  res.render('profile', { profile: row, flash: req.session.flash });
  req.session.flash = null;
});

// VULN: CSRF — updates state on POST with no anti-CSRF token and no SameSite
// cookie setting. A cross-origin form auto-submitted from an attacker page
// will silently change the victim's email while they're logged in.
router.post('/profile/update', requireLogin, async (req, res) => {
  const { email, bio } = req.body;
  await run(`UPDATE users SET email = ?, bio = ? WHERE id = ?`, [
    email,
    bio,
    req.session.user.id,
  ]);
  req.session.flash = 'Profile updated.';
  res.redirect('/profile');
});

// VULN: CSRF on password change. Same issue as /profile/update, worse blast.
router.post('/profile/password', requireLogin, async (req, res) => {
  const { password } = req.body;
  await run(`UPDATE users SET password = ? WHERE id = ?`, [
    password,
    req.session.user.id,
  ]);
  req.session.flash = 'Password changed.';
  res.redirect('/profile');
});

module.exports = router;
