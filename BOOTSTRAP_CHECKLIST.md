# 🚀 Bootstrap Checklist — Nouveau Repo

> **Important :** ce document doit être complété intégralement avant que le moindre code de production soit écrit sur ce repo. L'agent CTO ne démarre aucune feature tant que cette checklist n'est pas à 100 %.

---

## Partie 1 — Actions de l'agent CTO (automatiques)

L'agent CTO doit effectuer ces actions à l'initialisation du repo et les confirmer au board dans un ticket Paperclip dédié intitulé `[BOOTSTRAP] <nom-du-projet>`.

### Structure de fichiers à créer

- [ ] `.github/pull_request_template.md` (copié depuis le template)
- [ ] `.github/workflows/ci.yml` (copié depuis le template)
- [ ] `.github/ISSUE_TEMPLATE/bug_report.md`
- [ ] `.github/ISSUE_TEMPLATE/feature_request.md`
- [ ] `.gitignore` (inclut `.env.local`, `node_modules/`, `coverage/`, `playwright-report/`, `experiments/**/node_modules/`)
- [ ] `.env.example` (variables documentées avec valeurs fictives)
- [ ] `README.md` (setup, commandes, stack)
- [ ] `AGENTS.md` (mémoire partagée — créé vide mais initialisé, pointe vers les 3 charters)
- [ ] `ARCHITECTURE.md` (décisions structurelles — créé vide mais initialisé)
- [ ] `CHARTER-CORE.md` (charte commune — non-négociables transverses)
- [ ] `CHARTER-PROTO.md` (mode itération — workflow allégé, pas de PR)
- [ ] `CHARTER-PROD.md` (mode hardening — discipline complète)
- [ ] `BOOTSTRAP_CHECKLIST.md` (ce fichier, pour référence future)
- [ ] `specs/` (dossier créé avec un `.gitkeep`)
- [ ] `experiments/` (dossier créé avec `README.md` rappelant les règles d'isolation)
- [ ] `package.json` avec scripts `pnpm run check` ET `pnpm run check:fast` configurés
- [ ] `biome.json` (configuration Biome)
- [ ] `tsconfig.json` (TypeScript strict mode)
- [ ] `vitest.config.ts` (config Vitest avec coverage)
- [ ] `playwright.config.ts` (config Playwright si auth/paiement prévu)

### Premier commit

- [ ] Premier commit au format : `chore(init): bootstrap project structure [BOOTSTRAP]`
- [ ] Push sur `main` (uniquement pour ce commit initial, avant activation des protections)

### Ticket Paperclip de handoff

- [ ] Création d'un ticket Paperclip intitulé `[BOOTSTRAP] Configuration Settings GitHub — <nom-du-projet>`
- [ ] Ce ticket contient la **Partie 2** ci-dessous en copie pour le board humain
- [ ] Le ticket est assigné à l'humain (board), pas à un agent

---

## Partie 2 — Actions du board humain (manuelles, dans GitHub Settings)

> ⚠️ Ces étapes ne peuvent pas être effectuées par un agent. Elles constituent le point de contrôle ultime du board. L'agent CTO ne doit écrire aucune feature tant que la Partie 2 n'est pas validée.

### Accès : GitHub.com → ton repo → Settings

### A. Settings → General

- [ ] **Default branch** = `main`
- [ ] **Template repository** : décoché (sauf si ce repo est lui-même un template)
- [ ] **Features** : Issues activées, Discussions si souhaité
- [ ] **Pull Requests** :
  - [ ] Allow **squash merging** : coché
  - [ ] Allow **rebase merging** : coché
  - [ ] Allow **merge commits** : **décoché** (pour linear history)
  - [ ] Automatically delete head branches : coché

### B. Settings → Branches → Add branch protection rule

- [ ] **Branch name pattern** : `main`
- [ ] ✅ **Require a pull request before merging**
  - [ ] Require approvals : **1** minimum
  - [ ] Dismiss stale pull request approvals when new commits are pushed : coché
  - [ ] Require review from Code Owners : coché (si `CODEOWNERS` existe)
- [ ] ✅ **Require status checks to pass before merging**
  - [ ] Require branches to be up to date before merging : coché
  - [ ] Status checks requis (à sélectionner après le premier run de CI) :
    - [ ] `Quality Gate`
    - [ ] `Security Scan (Snyk)`
    - [ ] `Verify Conventions`
    - [ ] `E2E Tests (Playwright)` — uniquement pour repos auth/paiement
- [ ] ✅ **Require conversation resolution before merging**
- [ ] ✅ **Require linear history**
- [ ] ✅ **Do not allow bypassing the above settings** (s'applique aussi aux admins)
- [ ] ❌ **Allow force pushes** : décoché
- [ ] ❌ **Allow deletions** : décoché

### C. Settings → Secrets and variables → Actions

- [ ] `SNYK_TOKEN` ajouté (récupéré depuis snyk.io)
- [ ] Autres secrets documentés dans `.env.example` ajoutés ici
- [ ] **Aucun** secret n'est en clair dans le code ou les workflows

### D. Settings → Code security and analysis

- [ ] **Dependency graph** : activé
- [ ] **Dependabot alerts** : activé
- [ ] **Dependabot security updates** : activé
- [ ] **Secret scanning** : activé
- [ ] **Push protection** : activé (bloque les secrets au push)

### E. Settings → Collaborators and teams

- [ ] L'agent CTO (si compte GitHub dédié) a le rôle **Write** — pas Admin
- [ ] Le board humain a le rôle **Admin**
- [ ] Aucun autre collaborateur avec les permissions de merger sur `main` sans review

### F. Intégrations tierces (optionnelles mais recommandées)

- [ ] **SonarCloud** : projet créé et lié au repo
- [ ] **Vercel** : projet connecté pour le preview deploy sur chaque PR
- [ ] **Supabase** : projet créé et ses clés stockées dans les Secrets

### G. Paperclip — labels de mode

- [ ] Le projet Paperclip correspondant a deux labels créés : `mode:proto` et `mode:prod`
- [ ] La règle est documentée pour le CEO : tout ticket assigné à l'agent CTO doit porter un label de mode (par défaut `mode:proto`)
- [ ] L'agent CTO a été configuré pour lire ce label au démarrage de session et charger le bon charter

---

## Partie 3 — Validation finale

Une fois les Parties 1 et 2 complétées, l'agent CTO effectue un **test de bout en bout** :

- [ ] Crée une branche `chore/ticket-0-bootstrap-test`
- [ ] Modifie un fichier trivial (ex: ajoute une ligne dans `README.md`)
- [ ] Ouvre une PR via le template
- [ ] Vérifie que **toutes** les protections se déclenchent :
  - [ ] La CI tourne et passe
  - [ ] Le merge est bloqué tant que le board humain n'a pas approuvé
  - [ ] Un push direct sur `main` est refusé (test optionnel)
- [ ] Le board humain approuve et merge
- [ ] La branche est auto-supprimée après merge

Si tous les tests passent : le repo est **bootstrap-ready**. L'agent CTO peut commencer la première feature.

---

**Règle d'or :** si cette checklist n'est pas à 100 %, tout code écrit ensuite est à refaire. Les 30 minutes de setup évitent 30 heures de dette.
