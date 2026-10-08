# Guide de Configuration Supabase - Oasis Studio Coworking

Ce guide vous accompagne pas à pas pour connecter votre site statique Oasis Coworking à **Supabase**.

---

## 1. Créer le projet Supabase

1. Rendez-vous sur [supabase.com](https://supabase.com) et connectez-vous ou créez un compte.
2. Cliquez sur **New Project**.
3. Choisissez une organisation, donnez un nom à votre projet (ex: `oasis-coworking`) et définissez un mot de passe pour la base de données.
4. Sélectionnez la région la plus proche (ex: `eu-central-1` ou `eu-west-3`) et validez.

---

## 2. Exécuter le script SQL

1. Dans le menu de gauche de votre tableau de bord Supabase, cliquez sur **SQL Editor** (icône avec `>_`).
2. Cliquez sur **New query**.
3. Ouvrez le fichier [supabase-schema.sql](file:///d:/informatique/BM_concept/oasis/oasis/supabase-schema.sql) du projet, copiez l'intégralité de son contenu et collez-le dans l'éditeur.
4. Cliquez sur **Run** (ou `Ctrl + Entrée`).
5. Les tables suivantes seront créées avec sécurité RLS activée (lecture publique seule) et des données de test :
   - `postes` : Liste des 4 bureaux.
   - `disponibilites` : Statut (`libre` / `occupe`) pour chaque mois au format `AAAA-MM`.
   - `galerie` : Images avec URL et légendes.

---

## 3. Récupérer les clés d'API

1. Dans le tableau de bord Supabase, cliquez sur l'icône **Project Settings** (icône engrenage en bas à gauche).
2. Cliquez sur la section **API** (Data API).
3. Repérez deux valeurs :
   - **Project URL** (ex: `https://xyzabcdefghijklm.supabase.co`)
   - **anon / public** API Key (la clé publique commençant par `ey...`)

---

## 4. Configurer le code client

Ouvrez le fichier [js/supabase-client.js](file:///d:/informatique/BM_concept/oasis/oasis/js/supabase-client.js) et remplacez les valeurs de configuration :

```javascript
export const SUPABASE_URL = 'https://xyzabcdefghijklm.supabase.co';
export const SUPABASE_ANON_KEY = 'votre_cle_anon_ici';
```

---

## 5. Comment gérer vos données au quotidien

Depuis le tableau de bord Supabase, rendez-vous dans le **Table Editor** (icône tableau) :

### Modifier une disponibilité :
- Ouvrez la table `disponibilites`.
- Double-cliquez sur la colonne `statut` pour passer de `libre` à `occupe` (ou inversement).
- Pour ajouter un nouveau mois, cliquez sur **Insert row**, choisissez le `poste_id`, le `mois` (ex: `2026-11`) et le statut.

### Ajouter une photo à la galerie :
- Ouvrez la table `galerie`.
- Cliquez sur **Insert row**.
- Saisissez l'URL de votre photo (chemin local comme `images/fond.jpg` ou URL hébergée sur Supabase Storage / Imgur / Cloudinary), ajoutez une légende et un ordre d'affichage.
