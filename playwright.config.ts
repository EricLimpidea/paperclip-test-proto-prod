import { defineConfig, devices } from '@playwright/test';

/**
 * Configuration Playwright pour les tests E2E.
 * Obligatoire pour : flux d'authentification, flux de paiement.
 * Cf. charte CTO — Fondation 2.
 */
const env =
  (
    globalThis as typeof globalThis & {
      process?: { env?: Record<string, string | undefined> };
    }
  ).process?.env ?? {};

const isCi = env.CI != null;

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: isCi,
  retries: isCi ? 2 : 0,
  reporter: [['html', { open: 'never' }], ['list']],
  ...(isCi ? { workers: 1 } : {}),
  use: {
    baseURL: env.PLAYWRIGHT_BASE_URL ?? 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    // Activer si besoin multi-navigateur
    // { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    // { name: 'webkit', use: { ...devices['Desktop Safari'] } },
  ],
  ...(isCi
    ? {}
    : {
        webServer: {
          command: 'pnpm run dev',
          url: 'http://localhost:3000',
          reuseExistingServer: true,
          timeout: 120_000,
        },
      }),
});
