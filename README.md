<!-- foundation:identity -->
# probe-a4e8aa

One-page guestbook: visitors type a short message and see the wall of messages, newest first. No accounts, no commerce just write and read.

- Site: https://probe-a4e8aa.api.holode.xyz
- Support: support@probe-a4e8aa.api.holode.xyz
<!-- /foundation:identity -->

## What this is

One-page guestbook: visitors type a short message and see the wall of messages, newest first. No accounts, no commerce — just write and read.

## Main features

- **Leave a message** — Visitor types a name (optional) and a short message, submits, and it appears on the wall.
- **Read the wall** — Visitor sees all messages, newest first, on the single page.

## Core entities

- Message

## Run locally

```bash
bundle install
bin/rails db:prepare
bin/dev
```

Requires Ruby, PostgreSQL, and the usual Rails toolchain. See `bin/setup` if present.

## Demo

A few short welcome messages so the wall is not empty on first load.

## Deploy notes

Production `config.hosts` is derived from `domain` in `config/foundation.yml`. Keep that value aligned with the real host or every request will 403.
