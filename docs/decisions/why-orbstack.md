# Why OrbStack over Podman

I previously used Podman for: more open source, rootless security, and lighter
RAM usage. The trade-off was compatibility — most notably Supabase, whose
analytics container doesn't run under Podman (I didn't use analytics, so I lived
with it).

I switched to OrbStack because:

1. **Real Docker compatibility** — it ships an actual `docker` CLI and daemon, so
   Supabase (including analytics), Compose stacks, and anything that assumes
   Docker just work.
2. **Light on resources** — OrbStack is fast to start and uses little RAM, on par
   with or better than the Podman machine it replaces.
3. **`host.docker.internal`, Compose v2, and the Docker socket all work** out of
   the box, with no rootless UID-mapping surprises on volume permissions.

What I gave up:

- **Open source** — OrbStack is closed-source; Podman is not. (Docker Desktop is
  also closed-source, so this isn't unique to OrbStack — Podman was the only
  fully-OSS option.)
- **Free for commercial use** — OrbStack is free for personal/non-commercial use
  but charges $8/user/month for business/commercial use (free only if you earn
  under $10k/yr from it). Docker Desktop is free under 250 employees / $10M
  revenue, paid above. Podman is always free regardless. So Podman was the only
  always-free *and* fully-OSS choice; I traded that for real Docker compatibility.
