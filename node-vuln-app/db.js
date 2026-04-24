const sqlite3 = require('sqlite3');
const path = require('path');

const DB_PATH = path.join(__dirname, 'data', 'vuln.sqlite');
const db = new sqlite3.Database(DB_PATH);

// INTENTIONALLY VULNERABLE: a run() that accepts a raw SQL string.
// This is used by the vulnerable routes to make string-concat SQLi trivial to
// demonstrate. A real app would use parameterized queries everywhere.
function rawAll(sql) {
  return new Promise((resolve, reject) => {
    db.all(sql, (err, rows) => (err ? reject(err) : resolve(rows)));
  });
}

function rawGet(sql) {
  return new Promise((resolve, reject) => {
    db.get(sql, (err, row) => (err ? reject(err) : resolve(row)));
  });
}

function run(sql, params = []) {
  return new Promise((resolve, reject) => {
    db.run(sql, params, function (err) {
      if (err) reject(err);
      else resolve({ lastID: this.lastID, changes: this.changes });
    });
  });
}

function all(sql, params = []) {
  return new Promise((resolve, reject) => {
    db.all(sql, params, (err, rows) => (err ? reject(err) : resolve(rows)));
  });
}

function get(sql, params = []) {
  return new Promise((resolve, reject) => {
    db.get(sql, params, (err, row) => (err ? reject(err) : resolve(row)));
  });
}

module.exports = { db, rawAll, rawGet, run, all, get };
