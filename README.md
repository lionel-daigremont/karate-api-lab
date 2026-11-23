# karate-api-lab

API test automation lab with **Karate 1.5.1** (Java/Maven), focused on what real-world API suites need beyond a single-resource CRUD: **chaining and combining several APIs in one scenario**, reusable building blocks, environment configuration and **guaranteed test-data cleanup**.

Target API: public demo service `https://webservice.toscacloud.com/api/v1` (Shops, Coffees, Employee).

## What's covered

| Level | Feature file | Techniques |
|---|---|---|
| 1. Chaining calls | `examples/shops/shops.feature` | Shops list → shop detail → shop's coffees; `match each`, fuzzy markers (`#string` vs `##string`), empty-list guard `'#[_ > 0]'`, cross-call consistency instead of hard-coded values |
| 2. Injecting data from one API into another | `examples/shops/employee_shop.feature` | `karate.filter` on employees with an address → build a shop from employee data → POST → GET → DELETE → GET (204) |
| 3. Config, reuse & cleanup | `karate-config.js`, `create_shop.feature`, `delete_shop.feature` | Centralised `baseUrl` and `karate.env` (dev / staging / prod); reusable `call` features (`@ignore`); `configure afterScenario` as a safety net that deletes created data only if the scenario failed before its own DELETE step |

## Design choices

- **Strict vs tolerant schemas on purpose**: `#string` where a business rule applies (a shop always has a city), `##string` where real data is incomplete (coffees without a description).
- **Exact match (`==`) over `contains`** for structure checks: it caught a key typo (`zipcode` vs `zipCode`) that a tolerant `##` marker would have hidden.
- **The test vs the safety net**: the DELETE is a tested, reported step; the `afterScenario` cleanup only logs its errors.
- **Prod-safe tagging**: read-only scenarios tagged `@smoke` are the only ones meant to run against production.
## Findings on the API (exploratory notes)

- POST returns **200** instead of 201; GET on a deleted resource returns **204** instead of 404 (consistent across resources).
- Duplicate shops and coffees with empty fields are accepted (shared demo data, not cleaned up by other users).
- The API advertises `api-supported-versions: 1.0, 2.0`, a natural axis for v1/v2 regression tests.
## Run

```bash
mvn test                          # default environment
mvn test -Dkarate.env=staging     # select an environment
mvn test -Dkarate.options="--tags @smoke"
```

HTML report: `target/karate-reports/karate-summary.html`

## Next steps

- `Scenario Outline` with several data sets
- `callonce` for shared setup
- v1 vs v2 regression suite
---
Author: Lionel Daigremont, Senior QA Engineer (ISTQB Foundation). See also [playwright-iframe-lab](https://github.com/lionel-daigremont/playwright-iframe-lab).
 