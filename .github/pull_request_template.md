# Pull Request

## 🎯 Contexte

**Ticket Paperclip :** [PC-XXX](lien-vers-ticket-paperclip)
**Issue GitHub :** Closes #XXX

## 📝 Résumé (3 phrases max — plancher de compréhension)

<!--
Explique en 3 phrases maximum ce que fait cette PR,
de manière qu'une personne non-technique puisse comprendre.
Si tu ne peux pas l'expliquer en 3 phrases, c'est un signal pour refactoriser.
-->

1.
2.
3.

## 📂 Spec associée

<!-- Liste les fichiers de spec qui ont validé cette implémentation -->

- [ ] `specs/<feature>/requirements.md`
- [ ] `specs/<feature>/design.md`
- [ ] `specs/<feature>/tasks.md`

## ✅ Définition de "Terminé"

<!-- Toutes les cases doivent être cochées avant le merge -->

- [ ] `pnpm run check` passe à zéro erreur (Biome + TSC + Vitest + Semgrep)
- [ ] Un test unitaire couvre le cas principal de la fonctionnalité
- [ ] Si auth ou paiement : un test Playwright E2E passe
- [ ] Les commits suivent le format `type(scope): description [PC-<id>]`
- [ ] La branche suit la convention `type/ticket-<id>-<slug>`
- [ ] Les décisions techniques non-évidentes sont commentées dans le code
- [ ] Aucun secret, clé API ou token dans le code (tout via `process.env`)
- [ ] Les nouvelles dépendances ont été vérifiées (>6 mois, >1000 DL/semaine, maintenue)
- [ ] Si feature > 100 lignes : protégée par un feature flag
- [ ] `AGENTS.md` et `ARCHITECTURE.md` mis à jour si changement structurel
- [ ] La CI GitHub Actions est verte

## 🚀 Production-ready

<!-- Si cette PR touche à la production, vérifie : -->

- [ ] Endpoint `/health` toujours fonctionnel
- [ ] Logs structurés (pas de `console.log` bruts)
- [ ] Migrations DB idempotentes et versionnées
- [ ] Rollback testé sur staging

## 🔐 Sécurité

- [ ] Toute entrée utilisateur est traitée comme non fiable
- [ ] Toute route protégée vérifie l'authentification
- [ ] Les données utilisateur affichées sont sanitisées (XSS)
- [ ] Aucun avertissement Snyk High ou Critical

## 📸 Captures / Démonstration

<!-- Si changement UI ou comportement visible, ajoute captures ou vidéo -->

## 🧠 Notes pour le reviewer

<!--
Ce que tu veux attirer à l'attention du board humain qui va merger :
- Décisions techniques à valider
- Points d'incertitude
- Alternatives considérées et rejetées
-->

---

**Rappel :** seul le board humain peut merger sur `main`. L'agent CEO Paperclip peut recommander, mais ne déclenche pas le merge.
