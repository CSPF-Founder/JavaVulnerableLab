const fs = require('fs');
const path = require('path');

const dataDir = path.join(__dirname, 'data');
if (!fs.existsSync(dataDir)) fs.mkdirSync(dataDir, { recursive: true });

const dbFile = path.join(dataDir, 'vuln.sqlite');
if (fs.existsSync(dbFile)) fs.unlinkSync(dbFile);

const { run } = require('./db');

(async () => {
  await run(`CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE,
    password TEXT,
    email TEXT,
    role TEXT DEFAULT 'user',
    bio TEXT
  )`);

  await run(`CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author TEXT,
    body TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
  )`);

  await run(`CREATE TABLE files (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id INTEGER,
    filename TEXT,
    contents TEXT
  )`);

  // Passwords are plaintext on purpose — this lab is about the web vulns,
  // not hashing. The UNION SQLi demo relies on being able to read them.
  const users = [
    ['admin', 'admin123', 'admin@example.test', 'admin', 'Site administrator'],
    ['alice', 'wonderland', 'alice@example.test', 'user', 'Curious user'],
    ['bob', 'builder', 'bob@example.test', 'user', 'Builder'],
    ['carol', 'carolpass', 'carol@example.test', 'user', 'Quiet lurker'],
  ];
  for (const u of users) {
    await run(
      `INSERT INTO users (username, password, email, role, bio) VALUES (?, ?, ?, ?, ?)`,
      u
    );
  }

  const messages = [
    ['admin', 'Welcome to the board. Be nice.'],
    ['alice', 'Anyone up for a CTF this weekend?'],
    ['bob', 'Just finished the new tool shed.'],
  ];
  for (const m of messages) {
    await run(`INSERT INTO messages (author, body) VALUES (?, ?)`, m);
  }

  const files = [
    [1, 'admin-notes.txt', 'Root password rotation schedule: monthly.'],
    [2, 'alice-diary.txt', "Dear diary, today I learned about SQL injection."],
    [3, 'bob-invoice.txt', 'Invoice #42 — 3 hours of carpentry — $240.'],
    [4, 'carol-secret.txt', 'Carol keeps her secrets here.'],
  ];
  for (const f of files) {
    await run(
      `INSERT INTO files (owner_id, filename, contents) VALUES (?, ?, ?)`,
      f
    );
  }

  console.log(`Seeded ${dbFile}`);
  console.log('Demo users:');
  for (const u of users) console.log(`  ${u[0]} / ${u[1]} (${u[3]})`);
  process.exit(0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
