# Shop Billing Website

A single-file, offline-capable billing app for a small Indian shop, with optional Supabase cloud sync.

## Deploy on GitHub Pages
1. Create a new GitHub repo (or use an existing one).
2. Upload `index.html` to the repo root.
3. Go to Settings -> Pages, set the source to the main branch / root folder.
4. Your site will be live at `https://<username>.github.io/<repo>/`.

## First run
- Admin panel default password: `admin123` — change it under Admin -> Settings right away.
- Deleting a bill (in Recent Bills, Sales History, or the Customer Balance Book) requires a separate Delete Password, default `delete456`. Change both passwords under Admin -> Settings; they are independent of each other.
- Billing: choosing UPI shows the QR uploaded in Admin -> Settings. "Save & Send WhatsApp" (and the invoice popup button) opens WhatsApp with the customer number (10-digit numbers get +91) and the bill details.
- Without Supabase configured, all data (products, bills, payments, balances) is stored in the browser's localStorage only, per device.

## Enable Supabase cloud sync (optional, recommended for multi-device use)
1. Create a free project at supabase.com.
2. In the Supabase SQL editor, run the script in `supabase-setup.sql` (also pasted below).
3. In your Supabase project, go to Settings -> API and copy the "Project URL" and the "anon public" key.
4. In the app: Admin -> Settings -> Supabase Cloud Sync, paste the URL and key, click "Connect / Update".
5. The status pill top-right shows Synced / Syncing / Sync Error / Offline.

```sql
create table shopdata (
  id text primary key,
  data jsonb,
  updated_at timestamptz default now()
);
alter table shopdata enable row level security;
create policy "public access" on shopdata for all using (true) with check (true);
```

Note: this uses the public anon key with an open policy, which is fine for a single small shop but means anyone with the URL+key could read/write the data. Don't use this setup for sensitive data.

## Notes
- Admin password check is client-side only (simple, not bank-grade security).
- Invoices print in A4 or 80mm (thermal) width — choose the size in the print preview before printing.
