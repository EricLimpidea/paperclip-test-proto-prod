# CHARTER-PROD.md — Mode Production

> Chargé en complément de `CHARTER-CORE.md` quand le ticket porte le label `mode:prod`.
>
> **But du mode** : livrer du code dont la qualité se compound dans le temps au lieu de se dégrader.

---

## Spec d'abord, toujours — les 3 gates

Avant d'écrire une seule ligne de code, tu produis trois documents :

1. `specs/<feature>/requirements.md` — ce qu'on construit et **pourquoi**
2. `specs/<feature>/design.md` — **comment** on va le construire
3. `specs/<feature>/tasks.md` — étapes atomiques, chacune committable indépendamment

Tu ne passes à l'implémentation qu'après **validation explicite des trois documents par le CEO**. Tu échanges 50 micro-décisions contre 3 gates structurés.

Tu maintiens `AGENTS.md` et `ARCHITECTURE.md` à jour. Ce sont la mémoire partagée de l'entreprise.

---

## Vérification complète — la boucle obligatoire

Tu ne déclares jamais une tâche terminée sans avoir exécuté toi-même :

```bash
pnpm run check
# = lint + typecheck + test:coverage + security
# = biome check + tsc --noEmit + vitest run --coverage + semgrep --config=auto
```

Si ça échoue, tu corriges la cause racine. Pas de contournement.

**La CI bloque tout merge qui** :
- fait échouer cette suite
- introduit une vulnérabilité Snyk Critical
- fait baisser la couverture de tests sous les seuils définis dans `vitest.config.ts`
- ajoute un avertissement SonarCloud Critical ou High

**Pour toute feature touchant auth ou paiement** : les tests Playwright E2E ne sont pas optionnels. Le job `E2E Tests (Playwright)` du CI s'active via les labels `auth` ou `payment` sur la PR.

---

## Workflow feature

### 1. Explorer
Interroge le CEO avec des questions ciblées jusqu'à pouvoir écrire la spec. Plan Mode actif, lis sans écrire.

### 2. Planifier
Produis `plan.md`, fais-le valider. Ne t'engage sur rien avant ça.

### 3. Implémenter
Commits atomiques par sous-tâche. Pas de commits de 500 lignes.

**Format strict** : `type(scope): description courte [PC-<id>]`

Exemples :
- `feat(auth): add email verification [PC-42]`
- `fix(api): handle null user [PC-57]`

### 4. Vérifier
Session fraîche. Lance `pnpm run check`. Revois explicitement les cas limites : entrée vide, accès concurrent, échec réseau, données malformées, rate limits, frontières d'auth.

### 5. Livrer

**Branche** : `type/ticket-<id>-<slug-court>`
Exemples : `feat/ticket-42-email-verification`, `fix/ticket-57-null-user`

**PR** : utilise `.github/pull_request_template.md` (déjà présent dans le repo).

Le titre de la PR : `[PC-<id>] <titre>`. La CI vérifie automatiquement la convention de nommage de branche et la présence de `[PC-<id>]` dans le titre (job `Verify Conventions`).

**Merge** : uniquement après CI verte **ET** approbation humaine explicite du board (l'humain, pas l'agent CEO Paperclip).

---

## Traçabilité Paperclip ↔ GitHub

Chaque unité de travail existe à trois endroits qui doivent rester synchronisés :

1. **Ticket Paperclip** — source de vérité pour le "quoi" et le "pourquoi"
2. **Issue GitHub** — miroir technique, créée au moment où le ticket t'est assigné
3. **Pull Request** — le "comment", rattachée à l'Issue via `Closes #<numéro>`

**Règles** :
- Pas de PR sans Issue GitHub correspondante
- Pas d'Issue sans ticket Paperclip parent
- Le titre de la PR reprend l'ID du ticket Paperclip : `[PC-<id>] <titre>`
- À la fermeture de la PR, tu mets à jour le ticket Paperclip avec le lien du commit de merge

---

## Garde-fous GitHub (infrastructure, pas discipline)

Configurés une fois, non contournables par un agent. Détaillés dans `BOOTSTRAP_CHECKLIST.md` Partie 2.

- Branch protection sur `main` : pas de push direct, PR obligatoire
- Status checks obligatoires : `Quality Gate`, `Security Scan (Snyk)`, `Verify Conventions` (et `E2E Tests` pour repos auth/paiement)
- Au moins une review humaine requise avant merge
- Dismiss stale reviews quand la branche est mise à jour
- Linear history : rebase ou squash uniquement, pas de merge commits parasites

Si l'un de ces garde-fous est désactivé temporairement, c'est un **incident** à documenter dans `journal.md` et à restaurer dans les 24 heures.

---

## Définition de "Terminé"

Une tâche n'est terminée que quand **tous** ces critères sont remplis (cf checklist détaillée dans `.github/pull_request_template.md`) :

- `pnpm run check` passe à zéro erreur
- Un test couvre le cas principal de la fonctionnalité (`auth.ts` → `auth.test.ts` dans le même dossier)
- Pour auth et paiement : un test Playwright E2E passe
- Le commit est poussé sur la branche de travail avec un message au bon format
- Une PR est ouverte, liée à l'Issue GitHub et au ticket Paperclip
- La CI GitHub Actions est verte sur la PR
- Les décisions techniques non-évidentes sont documentées dans un commentaire dans le code
- Le merge sur `main` a été approuvé explicitement par le board humain

---

## Production-ready — au-delà des tests

Une feature qui passe la suite de vérification n'est pas nécessairement déployable. Avant tout merge vers `main`, tu vérifies :

- Un endpoint `/health` répond correctement
- Les erreurs sont capturées et produisent des **logs structurés** (pas de `console.log` bruts — Biome bloque déjà via la règle `noConsoleLog: error`)
- Les migrations de base de données sont versionnées et jouables de façon **idempotente**
- Le déploiement est **réversible** : la version N-1 peut être restaurée sans casser le schéma DB

La procédure de rollback (app + DB) est documentée et testée sur staging **avant** le premier go-live d'une feature critique.

---

## Feature flags

Toute feature de plus de 100 lignes est protégée par un feature flag. Sans exception. Les prototypes restent dans `experiments/` (mode proto) — ils ne sont jamais livrés directement en prod.

---

## Sécurité — rappels mode prod

Les non-négociables du `CHARTER-CORE.md` s'appliquent ici, plus :

- Snyk High ou Critical → bloquant. Ne jamais ignorer.
- Toute feature touchant un secret réel passe obligatoirement par ce mode (pas de proto sur les flux sensibles).
- Sanitisation systématique des données utilisateur en UI.

Rappel : 45 % des échantillons de code générés par IA introduisent une vulnérabilité OWASP Top 10. Tu n'es pas l'exception.

---

## Création d'un nouveau repo

Tu ne crées jamais un nouveau repo sans suivre intégralement `BOOTSTRAP_CHECKLIST.md`. Ce document contient la checklist obligatoire (structure de fichiers, ticket de handoff au board humain, test de bout en bout).

Tant que la procédure du checklist n'est pas terminée à 100 %, tu n'écris aucune feature.

---

## Discipline hebdomadaire

Chaque semaine tu produis pour le CEO :
- Un **changelog en langage produit** (pas de jargon technique) couvrant ce qui a été livré
- Une liste signalée de tout fichier dont la complexité dépasse le seuil ou déclenche un signal sécurité
- Un **audit des dépendances** ajoutées cette semaine

---

## Interdits — mode prod

En plus des interdits du `CHARTER-CORE.md` :

- Livrer du code qui fait échouer `pnpm run check`
- Déclarer une tâche terminée sans test correspondant
- Ajouter une feature de plus de 100 lignes sans feature flag
- Supprimer un avertissement linter pour aller plus vite
- Ignorer un avertissement Snyk de niveau High ou Critical
- Ouvrir une PR sans Issue GitHub correspondante (pas seulement sans ticket Paperclip)

---

> Ton travail n'est pas de livrer vite. Ton travail est de construire une organisation engineering — même si cette organisation est aujourd'hui deux agents et un humain — **dont la qualité se compound dans le temps au lieu de se dégrader.**
