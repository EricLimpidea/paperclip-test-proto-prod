# ARCHITECTURE.md

> Décisions structurelles de ce projet. À jour en permanence. Injecté au début de chaque session.

---

## Vue d'ensemble

_(À remplir : schéma haut-niveau du système. Composants principaux, frontières, flux de données.)_

---

## Stack technique active

| Couche | Technologie | Version | Notes |
|---|---|---|---|
| Frontend | TypeScript + React | _(à renseigner)_ | |
| Backend | Supabase | _(à renseigner)_ | |
| Déploiement | Vercel | n/a | |
| Tests unitaires | Vitest | _(à renseigner)_ | |
| Tests E2E | Playwright | _(à renseigner)_ | Activé pour : _(auth/paiement/...)_ |
| Qualité de code | Biome | _(à renseigner)_ | |

---

## Frontières et responsabilités

_(À remplir : qui est responsable de quoi. Frontend ↔ Backend ↔ Supabase ↔ services externes.)_

---

## Modèle de données

_(À remplir au fil de l'évolution du projet. Tables principales, relations, contraintes RLS Supabase.)_

---

## Flux critiques

_(À documenter : auth, paiement, et tout flux jugé critique pour le métier. Schéma de séquence si utile.)_

### Authentification
_(à remplir si applicable)_

### Paiement
_(à remplir si applicable)_

---

## Décisions architecturales (ADR)

_Format léger : date — décision — alternatives considérées — pourquoi celle-ci_

### ADR-001 : Choix du repo template `paperclip-project-template`
- **Date :** _(date du bootstrap)_
- **Décision :** projet bootstrappé depuis le template gouverné par le board
- **Alternatives :** structure ad-hoc, ce qui aurait fragmenté la gouvernance
- **Pourquoi :** alignement sur les standards de l'organisation, économie de setup, cohérence inter-projets

### ADR-XXX : _(à ajouter au fil du projet)_

---

## Dépendances externes critiques

_(Liste des services tiers dont la disponibilité conditionne celle du projet : Supabase, Vercel, fournisseurs d'auth/paiement, etc.)_

| Service | Usage | Plan de fallback |
|---|---|---|
| Supabase | DB + auth + API | _(à définir)_ |
| Vercel | Hosting + CI deploy | _(à définir)_ |

---

## Points connus à surveiller

_(Limitations connues, dette technique acceptée, hotspots de complexité.)_

- _(vide pour l'instant)_
