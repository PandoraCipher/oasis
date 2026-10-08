-- 1. Nettoyage (si rejoué)
DROP TABLE IF EXISTS disponibilites CASCADE;
DROP TABLE IF EXISTS postes CASCADE;
DROP TABLE IF EXISTS galerie CASCADE;
-- 2. Table des postes
CREATE TABLE postes (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);
-- 3. Table des disponibilités par mois
CREATE TABLE disponibilites (
    id SERIAL PRIMARY KEY,
    poste_id INTEGER NOT NULL REFERENCES postes(id) ON DELETE CASCADE,
    mois VARCHAR(7) NOT NULL,
    -- Format : AAAA-MM (ex: '2026-10')
    statut TEXT NOT NULL CHECK (statut IN ('libre', 'occupe')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT unique_poste_mois UNIQUE (poste_id, mois)
);
-- 4. Table de la galerie d'images
CREATE TABLE galerie (
    id SERIAL PRIMARY KEY,
    url TEXT NOT NULL,
    legende TEXT,
    ordre INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);
ALTER TABLE postes ENABLE ROW LEVEL SECURITY;
ALTER TABLE disponibilites ENABLE ROW LEVEL SECURITY;
ALTER TABLE galerie ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique des postes" ON postes FOR
SELECT TO anon,
    authenticated USING (true);
CREATE POLICY "Lecture publique des disponibilites" ON disponibilites FOR
SELECT TO anon,
    authenticated USING (true);
CREATE POLICY "Lecture publique de la galerie" ON galerie FOR
SELECT TO anon,
    authenticated USING (true);
-- Insertion des 4 postes
INSERT INTO postes (id, nom, description)
VALUES (1, 'Poste 1', 'Bureau individuel - Poste calme'),
    (
        2,
        'Poste 2',
        'Bureau individuel - Proche fenêtre'
    ),
    (3, 'Poste 3', 'Bureau individuel - Grand écran'),
    (
        4,
        'Poste 4',
        'Bureau individuel - Poste lumineux'
    ) ON CONFLICT (id) DO NOTHING;
-- Insertion des disponibilités d'exemple
-- Remplacer ou compléter selon les mois réels (Format AAAA-MM)
INSERT INTO disponibilites (poste_id, mois, statut)
VALUES (1, '2026-10', 'occupe'),
    (1, '2026-11', 'occupe'),
    (1, '2026-12', 'libre'),
    (2, '2026-10', 'libre'),
    (2, '2026-11', 'libre'),
    (2, '2026-12', 'libre'),
    (3, '2026-10', 'occupe'),
    (3, '2026-11', 'libre'),
    (3, '2026-12', 'libre'),
    (4, '2026-10', 'libre'),
    (4, '2026-11', 'libre'),
    (4, '2026-12', 'libre') ON CONFLICT (poste_id, mois) DO
UPDATE
SET statut = EXCLUDED.statut;
-- Insertion des photos par défaut dans la galerie
INSERT INTO galerie (url, legende, ordre)
VALUES (
        'images/fond.jpg',
        'Espace de travail principal d''Oasis Studio Coworking',
        1
    ) ON CONFLICT DO NOTHING;