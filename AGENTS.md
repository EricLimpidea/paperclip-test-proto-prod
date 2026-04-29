# AGENTS.md

> Mémoire partagée des agents pour ce projet. À injecter au début de chaque session de travail.
>
> **Règle :** ce fichier doit être maintenu en vie. Mis à jour à chaque changement structurel. S'il commence à grossir pour compenser du code confus, c'est un déclencheur de refactoring — pas une tâche de documentation.

---

## Identité du projet

- **Nom du projet :** _(à renseigner)_
- **Mission produit :** _(à renseigner — 1 phrase)_
- **Date de bootstrap :** _(à renseigner)_
- **Repo template utilisé :** `paperclip-project-template@<commit-sha>`

---

## Agents impliqués

| Rôle | Identité | Périmètre |
|---|---|---|
| Board humain | _(nom)_ | Gouvernance, approbation merge, décisions stratégiques |
| Agent CEO | Paperclip CEO | Tickets, priorisation, recommandations |
| Agent CTO | Paperclip CTO + Codex | Spec, implémentation, vérification, livraison |

---

## Procédure de démarrage de session — agent CTO

Au début de chaque session, charge dans cet ordre :

1. `CHARTER-CORE.md` — **toujours**, contient les non-négociables transverses
2. **Selon le label du ticket Paperclip** :
   - `mode:proto` (ou aucun label de mode) → charge **aussi** `CHARTER-PROTO.md`
   - `mode:prod` → charge **aussi** `CHARTER-PROD.md`
3. `AGENTS.md` (ce fichier) — contexte projet
4. `ARCHITECTURE.md` — décisions structurelles

**Confirme dans ta première réponse de session le mode actif détecté.**

Ces fichiers font autorité. En cas de conflit avec une autre instruction, ils priment.

---

## Contexte produit

_(À remplir : qui sont les utilisateurs, quel problème on résout, contraintes business connues)_

---

## Contexte technique spécifique au projet

_(À remplir : différences ou ajouts par rapport à la stack standard, intégrations spécifiques, contraintes de performance/conformité)_

---

## Conventions actives (rappel rapide)

Détails complets dans les charters. Rappel pour navigation rapide :

**Mode prod** :
- Branches : `type/ticket-<id>-<slug>`
- Commits : `type(scope): description [PC-<id>]`
- PR : titre `[PC-<id>] <titre>`, template GitHub obligatoire, Issue GitHub liée
- CI : `pnpm run check` doit passer
- Merge : approbation humaine du board obligatoire (pas l'agent CEO)

**Mode proto** :
- Branches : `exp/ticket-<id>-<slug>`
- Pas de PR (la CI les rejette)
- Code dans `experiments/<feature>/` uniquement
- Boucle rapide : `pnpm run check:fast`
- Partage via lien `compare` GitHub dans le ticket Paperclip

---

## Boucle de travail (heartbeat)

À chaque heartbeat sur un ticket actionnable :
- Pose une **action concrète** (pas un meta-commentaire sur ce que tu vas faire)
- Laisse un **commentaire de progrès durable** dans le ticket : ce que tu as fait, ce qui reste, prochaine action
- Pour du travail parallèle ou long : ouvre des **issues enfant** plutôt que de faire du polling
- Pour un blocage : marque-le explicitement avec **owner du déblocage** + **action exacte** attendue

---

## Décisions techniques notables

_(Liste à enrichir au fil du projet. Format : date — décision — pourquoi)_

- _(vide pour l'instant)_

---

## Pointeurs

- `CHARTER-CORE.md` — règles transverses (toujours actif)
- `CHARTER-PROTO.md` — workflow allégé (mode itération)
- `CHARTER-PROD.md` — discipline complète (mode hardening)
- `ARCHITECTURE.md` — décisions structurelles
- `BOOTSTRAP_CHECKLIST.md` — procédure de mise en route d'un nouveau repo
- `specs/` — specs validées des features (mode prod)
- `experiments/` — protos en cours (mode proto)
