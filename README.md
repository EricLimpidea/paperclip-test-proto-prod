# Paperclip Project Template

> Repo template officiel pour tous les nouveaux projets de l'organisation. Source de vérité de la baseline bootstrap gouvernée par le board.

## À quoi sert ce repo

Ce repo n'est pas un projet — c'est un **moule**. Tout nouveau projet de l'organisation est créé via l'option GitHub **"Use this template"** à partir de ce repo. Il garantit que chaque projet démarre avec :

- La structure de fichiers standard
- La CI GitHub Actions configurée
- Le template de Pull Request aligné sur la charte CTO
- Les fichiers de mémoire partagée (`AGENTS.md`, `ARCHITECTURE.md`)
- La checklist de bootstrap obligatoire

## Comment l'utiliser

### Pour le board humain (gouvernance du template)

Toute modification de ce repo est une **décision de gouvernance** qui s'applique à tous les futurs projets. Les modifications passent par PR + approbation explicite du board.

Si la baseline doit évoluer (nouvelle règle de sécurité, nouveau check CI, nouvelle config) :
1. PR sur ce repo
2. Approbation du board
3. Communication aux agents que la baseline a évolué (mise à jour de `AGENTS.md` côté projet existant si rétro-compatible)

### Pour les agents (consommation du template)

Vous **n'écrivez jamais directement** dans ce repo. Vous l'utilisez via :
- L'option GitHub "Use this template" → bouton vert sur la page du repo
- Le skill `bootstrap-new-repo` documente la procédure complète

## Structure fournie

```
.
├── .github/
│   ├── pull_request_template.md       # Template PR aligné charte (mode prod)
│   ├── workflows/
│   │   └── ci.yml                      # Quality Gate + Snyk + Conventions (rejette les PR exp/)
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── specs/                              # Specs des features mode prod (1 dossier/feature)
├── experiments/                        # Protos mode proto (jetables, isolés)
│   └── README.md                       # Règles d'isolation
├── .env.example                        # Variables d'env documentées
├── .gitignore                          # Standard Node + Vercel + Playwright + isolation experiments
├── AGENTS.md                           # Mémoire partagée — pointe vers les 3 charters
├── ARCHITECTURE.md                     # Décisions structurelles (squelette)
├── CHARTER-CORE.md                     # Charte commune — non-négociables transverses
├── CHARTER-PROTO.md                    # Mode itération — workflow allégé, sans PR
├── CHARTER-PROD.md                     # Mode hardening — discipline complète
├── BOOTSTRAP_CHECKLIST.md              # Checklist obligatoire au bootstrap
├── README.md                           # Ce fichier (à remplacer par projet)
├── biome.json                          # Config Biome
├── package.json                        # Scripts `check` (mode prod) et `check:fast` (mode proto)
├── playwright.config.ts                # Config Playwright (auth/paiement)
├── tsconfig.json                       # TypeScript strict
└── vitest.config.ts                    # Vitest avec coverage
```

## Système de modes

L'agent CTO bascule entre deux niveaux de discipline selon le label du ticket Paperclip :

| Label | Charter chargé | Workflow |
|---|---|---|
| `mode:proto` (défaut) | CORE + PROTO | `experiments/`, branches `exp/`, **pas de PR**, partage par lien `compare` |
| `mode:prod` | CORE + PROD | `src/`, branches `type/ticket-`, PR + Issue + spec en 3 fichiers, CI complète |

Le code de proto **n'est jamais mergé sur `main`**. Quand une hypothèse est validée, un nouveau ticket `mode:prod` "Hardening de \<feature\>" est ouvert, et le code est **réécrit** sous discipline complète.

## Activation comme template

Dans **Settings → General**, cocher la case **"Template repository"** en haut de la page. Sans cette case cochée, l'option "Use this template" n'apparaît pas.

## Stack technique de référence

| Couche | Technologie |
|---|---|
| Frontend | TypeScript + React |
| Backend | Supabase |
| Déploiement | Vercel |
| Tests unitaires | Vitest |
| Tests E2E | Playwright |
| Qualité de code | Biome |
| Gestion de code | GitHub |
| Orchestration | Paperclip |

---

**Gouvernance :** ce repo est la source de vérité. Toute divergence dans un projet existant doit être documentée dans le `journal.md` de ce projet et justifiée.
