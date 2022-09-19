---
team: Homestars Enablement Team
datadog_service_identifiers:
  - accounts-contracts-api
  - accounts-contracts-api-postgres
  - accounts-contracts-api-que
tags:
  - accounts-contracts-api
contacts:
  - name: Homestars Enablement Slack Channel
    type: slack
    contact: https://homestars.slack.com/archives/C01A0N6BA9K
docs:
  - name: Service Level Agreement
    url: https://github.com/homestars/eng-handbook/blob/master/systems/homestars-pro/accounts-contracts-api/sla.md
  - name: Service Level Objectives
    url: https://github.com/homestars/eng-handbook/blob/master/systems/homestars-pro/accounts-contracts-api/slo.md
  - name: Production API Docs
    provider: swagger
    url: http://accounts-contracts-api.homestars.live/api-docs/index.html
  - name: Staging API Docs
    provider: swagger
    url: http://accounts-contracts-api.homestars.rocks/api-docs/index.html
  - name: Integration API Docs
    provider: swagger
    url: http://accounts-contracts-api.homestars.run/api-docs/index.html
repos:
  - name: accounts-contracts-api source
    provider: Github
    url: https://github.com/homestars/accounts-contracts-api
links:
  - name: DataDog API
    type: link
    url: https://app.datadoghq.com/apm/services/accounts-contracts-api/operations/rack.request/resources
  - name: DataDog Postgres
    type: link
    url: https://app.datadoghq.com/apm/services/accounts-contracts-api-postgres/operations/postgres.query/resources
  - name: DataDog Que
    type: link
    url: https://app.datadoghq.com/apm/services/accounts-contracts-api-que/operations/que.job/resources
  - name: Service Documentation
    type: link
    url: https://github.com/homestars/eng-handbook/tree/master/systems/homestars-pro/accounts-contracts-api
  - name: Production Service Dashboard
    type: dashboard
    url: http://accounts-contracts-api.homestars.live/chi/jobs
  - name: Staging Service Dashboard
    type: dashboard
    url: http://accounts-contracts-api.homestars.rocks/chi/jobs
  - name: Integration Service Dashboard
    type: dashboard
    url: http://accounts-contracts-api.homestars.run/chi/jobs
  - name: Troubleshooting and Diagnosis
    type: runbook
    url: https://github.com/homestars/eng-handbook/tree/master/systems/homestars-pro/accounts-contracts-api/run_books

integrations:
  pagerduty: https://homestars.pagerduty.com/service-directory/PS6XVU1
---

# Normal Markdown Documentation Stuff

This area will be ignored by the front matter parser ...
