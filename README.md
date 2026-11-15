# Job Tracker — deployment guide

This is a real website: anyone can create their own account and gets their own
private job board. It costs nothing at this scale (both services below have
generous free tiers). You'll need about 20–30 minutes.

## 1. Create the database + auth backend (Supabase)

1. Go to https://supabase.com → sign up (free) → "New project".
2. Pick any project name and a database password (save it somewhere).
3. Once the project is ready, go to the **SQL Editor** (left sidebar) → "New query".
4. Paste in the entire contents of `schema.sql` (included here) → click **Run**.
   This creates the `jobs` table and locks it so each signed-in person can only
   ever see or change their own rows.
5. Go to **Project Settings → API**. You'll see:
   - **Project URL**
   - **anon public** key
6. Open `config.js` in this folder and paste those two values in, replacing the
   placeholders.
7. (Optional but recommended for a public site) Go to **Authentication →
   Providers → Email** and turn OFF "Confirm email" only if you want people to
   start using their account immediately without checking their inbox first —
   otherwise leave it on for a safer default.

## 2. Put the website online (Vercel)

1. Go to https://vercel.com → sign up (free, you can use GitHub or just email).
2. Click **Add New → Project → Deploy without a Git repository** (or drag-and-drop):
   - Zip the four files `index.html`, `app.html`, `config.js`, `styles.css` into
     one folder and drag that folder onto Vercel's upload area, OR
   - If you're comfortable with GitHub: create a new repo, upload these files,
     then "Import" that repo into Vercel.
3. Vercel will give you a live URL like `https://job-tracker-yourname.vercel.app`
   within about a minute. That's it — it's live, on the internet, for anyone.

## 3. (Optional) Use your own domain name

- Buy a domain (e.g. from Namecheap or Google Domains, ~$10–15/year).
- In Vercel: **Project → Settings → Domains → Add**, then follow the DNS steps
  it gives you. Takes effect within a few minutes to a few hours.

## What each file does

| File | Purpose |
|---|---|
| `index.html` | Sign in / sign up page |
| `app.html` | The job board itself (only reachable once signed in) |
| `styles.css` | Shared visual styling |
| `config.js` | Your Supabase project's connection details |
| `schema.sql` | One-time database setup — run this in Supabase, not deployed |

## Before you open this to strangers

- Add a short Privacy Policy and Terms of Use page — required once real
  strangers are creating accounts and storing data, even informally. I can
  draft these for you if you'd like.
- Supabase's free tier supports up to 50,000 monthly active users and 500MB of
  database storage — more than enough to start, and you'll get a plain warning
  by email before anything would be interrupted.
- Nobody but you can see this code or these setup steps — the deployed site
  only shows the sign-in page and the board.
