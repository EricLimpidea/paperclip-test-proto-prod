# experiments/

> Dossier réservé au **mode proto** (label `mode:proto` sur le ticket Paperclip).
> Voir `CHARTER-PROTO.md` à la racine du repo.

## Règles d'isolation (intangibles)

### Pas d'import depuis `src/`
Le code dans `experiments/` n'est **jamais** importé par le code de production.
Aucun `import ... from "experiments/..."` dans `src/`.

### Pas de pollution du `package.json` racine
Si un proto a besoin d'une dépendance expérimentale, elle va dans un
`package.json` LOCAL au dossier `experiments/<feature>/`, jamais dans le
`package.json` racine.

Les `node_modules/`, `package-lock.json` et `pnpm-lock.yaml` locaux à
`experiments/` sont ignorés par `.gitignore`.

### Pas de secrets réels
Stubs, mocks et fixtures uniquement. Si un proto a besoin de tester contre
un vrai service externe, il doit basculer en `mode:prod` (nouveau ticket).

### Pas de PR vers `main`
Les branches `exp/ticket-<id>-<slug>` ne peuvent **pas** ouvrir de PR
(rejeté par la CI). Le partage avec le board se fait via lien `compare`
dans le ticket Paperclip.

### Durée de vie maximale : 14 jours
Au-delà :
- soit promotion vers prod (nouveau ticket `mode:prod`, réécriture sous
  `CHARTER-PROD.md`, pas de copier-coller)
- soit suppression du dossier `experiments/<feature>/` et de la branche

## Structure attendue d'un proto

```
experiments/<feature>/
├── plan.md              # Objectif, hypothèse, critère de succès, étapes (≤30 lignes)
├── package.json         # OPTIONNEL — uniquement si deps expérimentales
└── ...                  # Code de l'expérimentation
```
