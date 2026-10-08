import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

// =====================================================================
// CONFIGURATION SUPABASE
// Remplacez ces valeurs par celles de votre projet Supabase :
// Dashboard Supabase -> Project Settings -> API -> Project URL & Project API Keys (anon / public)
// =====================================================================
export const SUPABASE_URL = 'https://nswnozleulbtldcompsc.supabase.co';
export const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zd25vemxldWxidGxkY29tcHNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTEzNTQ2MTIsImV4cCI6MjEwNjkzMDYxMn0.00E5Kz6jQ64brYeuG1UGlDN5YCLgpntU6yPvZPth1D4';

// Détection de configuration
export const isConfigured = 
  Boolean(SUPABASE_URL && SUPABASE_ANON_KEY) &&
  !SUPABASE_URL.includes('VOTRE_') &&
  !SUPABASE_ANON_KEY.includes('VOTRE_');

// Client Supabase avec fallback de sécurité si non configuré
export const db = isConfigured
  ? createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
  : {
      from: () => ({
        select: () => Promise.resolve({ data: null, error: new Error('Supabase non configuré') }),
        order: () => Promise.resolve({ data: null, error: new Error('Supabase non configuré') })
      })
    };

// Exposer sur window pour compatibilité
if (typeof window !== 'undefined') {
  window.db = db;
}