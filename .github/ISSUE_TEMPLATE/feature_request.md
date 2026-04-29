---
name: ✨ Feature Request
about: Issue technique miroir d'un ticket Paperclip de feature
title: '[PC-XXX] '
labels: feature
assignees: ''
---

## Ticket Paperclip parent (obligatoire)

<!-- Lien obligatoire — pas d'Issue sans ticket Paperclip parent -->
PC-XXX :

## Objectif produit

<!-- Repris du ticket Paperclip — pourquoi on construit ça -->

## Spec validée

<!-- Lien vers les 3 documents de spec (cf. Fondation 1 de la charte) -->

- [ ] `specs/<feature>/requirements.md` validé par le board
- [ ] `specs/<feature>/design.md` validé par le board
- [ ] `specs/<feature>/tasks.md` validé par le board

## Périmètre

<!-- Ce qui est inclus / exclu -->

**Inclus :**
-

**Exclu :**
-

## Critères de "Terminé"

<!-- Repris de la Définition de "Terminé" charte + spécifiques au ticket -->

- [ ] `pnpm run check` à zéro erreur
- [ ] Test unitaire du cas principal
- [ ] Test Playwright E2E si auth/paiement
- [ ] Feature flag si > 100 lignes
- [ ] PR liée à cette Issue avec `Closes #<numéro>`
- [ ] Approbation board humain

## Branche prévue

<!-- Format : type/ticket-<id>-<slug> -->
`feat/ticket-XXX-`

## Dépendances / blocages

<!-- Autres tickets ou décisions qui doivent être résolus avant -->
