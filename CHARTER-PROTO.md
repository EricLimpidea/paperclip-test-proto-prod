# CHARTER-PROTO.md — Mode Prototype

> Chargé en complément de `CHARTER-CORE.md` quand le ticket porte le label `mode:proto` (ou aucun label de mode).
>
> **But du mode** : valider une hypothèse vite. Le code prototype est jetable par construction. Il n'atteindra **jamais** `main`.

---

## Principe fondateur

Le code prototype et le code de production ne sont **pas** le même code à des étapes différentes. Ce sont deux artefacts distincts.

Quand l'hypothèse est validée, on ne "promeut" pas le code. On ouvre un nouveau ticket `mode:prod` "Hardening de \<feature\>" et on **réécrit** sous la discipline complète. Pas de copier-coller automatique.

Cette séparation est ce qui permet d'aller vite sans corrompre la base de prod.

---

## Spec — un seul fichier

Pas de `requirements.md` ni `design.md` séparés. Un seul fichier suffit :

```
experiments/<feature>/plan.md
```

**Format** (≤ 30 lignes, 4 sections) :

1. **Objectif** — ce qu'on cherche à apprendre
2. **Hypothèse** — ce qu'on pense être vrai et qu'on veut vérifier
3. **Critère de succès** — quoi observer pour conclure
4. **Étapes** — liste courte d'actions

Validation CEO légère : un OK dans le ticket Paperclip suffit. Pas de gate à 3 documents.

---

## Vérification — boucle rapide

Tu utilises la suite courte :

```bash
pnpm run check:fast
# = lint (biome check) + typecheck (tsc --noEmit)
```

**Tests** : un smoke test sur le chemin heureux suffit. Pas plus.

**Ce qui n'est PAS exigé en mode proto** :
- Pas de Playwright E2E
- Pas de couverture de tests minimale
- Pas de Snyk bloquant
- Pas de SonarCloud bloquant

**Exception** : si ton prototype touche un flux d'authentification ou de paiement réel (pas mocké), tu repasses en `mode:prod`. Pas de prototype léger sur ces zones.

---

## Branche & livraison — pas de PR

**Branche** : `exp/ticket-<id>-<slug-court>`
Exemple : `exp/ticket-89-trial-onboarding-flow`

**Commit** : format simple, pas de scope strict requis.
Exemple : `exp(onboarding): test wizard step ordering [PC-89]`

### IMPORTANT — Pas de Pull Request

Les branches `exp/` ne peuvent **PAS** ouvrir de PR. La CI rejette automatiquement toute PR dont la branche source commence par `exp/`. C'est volontaire et structurel.

### Comment partager ton travail avec le board

Tu push ta branche, puis tu postes dans le ticket Paperclip un message au format :

```
## Branche
https://github.com/<user>/<repo>/tree/exp/ticket-89-xxx

## Vue diff (compare avec main)
https://github.com/<user>/<repo>/compare/main...exp/ticket-89-xxx

## Ce que j'ai testé
[1 phrase]

## Ce que j'ai appris
- [point 1]
- [point 2]
- [point 3]

## Recommandation
[ ] Promouvoir en prod (ouvrir un ticket mode:prod "Hardening de <feature>")
[ ] Pivoter (modifier l'hypothèse)
[ ] Abandonner (l'hypothèse ne tient pas)
```

Le CEO clique sur le lien `compare` pour voir le diff complet et valide/rejette dans le ticket Paperclip.

---

## Limites du mode — intangibles

### Isolation du code
- Le code dans `experiments/` n'est **jamais** importé par le code de production. Aucun `import` depuis `src/` vers `experiments/`.
- Cette règle peut être vérifiée par un grep simple. C'est ta responsabilité de ne pas la violer.

### Isolation des dépendances
- Aucune dépendance ajoutée au `package.json` racine pour les besoins d'un proto.
- Si tu as besoin d'une lib expérimentale, tu utilises un `package.json` LOCAL au dossier `experiments/<feature>/`.
- `node_modules/`, `package-lock.json` et `pnpm-lock.yaml` locaux à `experiments/` sont déjà ignorés par `.gitignore`.

### Isolation des secrets
- Aucun secret réel en mode proto. Stubs, mocks, fixtures uniquement.
- Si tu as besoin de tester contre un vrai service, tu repasses en `mode:prod`.

### Durée de vie maximale — 14 jours
- Au-delà : promotion en `mode:prod` ou suppression du dossier `experiments/<feature>/` et de la branche.
- Un proto qui traîne devient une dette silencieuse. Pas de "on garde au cas où".

---

## Promotion vers la production

Quand le CEO valide l'hypothèse testée :

1. **Tu ouvres un nouveau ticket Paperclip** avec label `mode:prod`, intitulé "Hardening de \<feature\>".
2. La session de hardening charge `CHARTER-PROD.md`.
3. Tu produis les 3 documents de spec (`requirements.md`, `design.md`, `tasks.md`).
4. Tu **réécris** sous la discipline complète. Le code de proto sert de référence comportementale, pas de source à copier.
5. Une fois la version prod livrée et mergée, le dossier `experiments/<feature>/` est supprimé et la branche `exp/` est supprimée.

Cette étape paraît coûteuse mais elle est ce qui garantit que la qualité de la prod ne dégrade pas. Sans elle, tu accumules du code "qui marche" mais que personne ne maîtrise.

---

## Discipline de fin de session proto

À la fin d'une session de prototypage, tu écris dans le ticket Paperclip :

- Ce que tu as testé (1 phrase)
- Ce que tu as appris (1-3 puces)
- Recommandation : promouvoir / pivoter / abandonner

C'est cette synthèse qui rend le mode proto utile. Sans synthèse, le code jeté n'a rien produit.
