# Datadog::ServiceCatalog

[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=homestars_datadog-service_catalog&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=homestars_datadog-service_catalog) [![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=homestars_datadog-service_catalog&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=homestars_datadog-service_catalog) [![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=homestars_datadog-service_catalog&metric=sqale_index)](https://sonarcloud.io/summary/new_code?id=homestars_datadog-service_catalog)

Use Markdown front matter to update [DataDog's ServiceCatalog](https://docs.datadoghq.com/tracing/service_catalog/)

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'datadog-service_catalog'
```

### Usage

#### Prerequisites

You need:

1. [Datadog API key](https://app.datadoghq.com/organization-settings/api-keys)
2. and a [Datadog Application Key](https://app.datadoghq.com/organization-settings/application-keys)

####  Configuration

If using in a Rails project, setup an initializer to configure the gem:

```ruby
Datadog::ServiceCatalog.configure do |config|
  config.datadog_api_key = '...'
  config.datadog_application_key = '...'
  config.markdown_file = 'service_catalog.md'
end
```

#### Front Matter Setup

Add [YAML front matter](https://wowchemy.com/docs/content/front-matter/) to the configuration specified Markdown file that follows the [Service Catalog Schema](https://github.com/DataDog/schema/blob/main/service-catalog/v2/schema.json). The one exception is a mandatory key `datadog_service_identifiers` that is used by this gem to know what service(s) should get the specified service definition. You can review a full example in the [sample_frontmatter.md file](docs/sample_frontmatter.md).

```yaml
---
team: Homestars Enablement Team
datadog_service_identifiers:
  - accounts-contracts-api
  - accounts-contracts-api-postgres
  - accounts-contracts-api-que
tags:
  - accounts-contracts-api
# continue adding service catalog supported keys and values here ...
---
```



#### Rake

Add the following to your Rakefile:

```ruby
require 'datadog/service_catalog/rake_tasks'

Datadog::ServiceCatalog::RakeTasks::Validate.new
Datadog::ServiceCatalog::RakeTasks::UploadAll.new('service_catalog', ['service_catalog:validate', :environment])
```

This provides two new rake tasks: 1) `service_catalog:validate`; 2) `service_catalog:upload_all`

### References

* [Service Catalog Schema](https://github.com/DataDog/schema/blob/main/service-catalog/v2/schema.json)
* [JSON Schema](https://json-schema.org)

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/homestars/datadog-service_catalog.
