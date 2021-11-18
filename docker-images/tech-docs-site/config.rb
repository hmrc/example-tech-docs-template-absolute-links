require 'govuk_tech_docs'

GovukTechDocs.configure(self)

set :relative_links, true
activate :relative_assets

configure :build do
  set :build_dir, 'build'
end