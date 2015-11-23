" Rails Projections - 

" `%s`: `{}` (Original)
" `%S`: `{camelcase|capitalize|colons}` (Ruby class name)
" `%S`: `{camelcase|capitalize|dot}` (JavaScript class name)
" `%p`: `{plural}`
" `%i`: `{singular}`
" `%h`: `{underscore|capitalize|blank}`
"
" Affinity
" affinity: "collection" - Corresponds to plural
" affinity: "resource" - Corresponds to singular
" affinity: "model"
" affinity: "controller"
"
" globals
let g:rails_projections = {
  \ "config/database.yml": {
  \   "command":   "database"
  \ },
  \ "test/factories/*.rb": {
  \   "command":   "factory",
  \   "affinity":  "collection",
  \   "alternate": "app/models/%i.rb",
  \   "related":   "db/schema.rb#%s",
  \   "test":      "test/models/%i_test.rb",
  \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
  \   "keywords":  "factory sequence"
  \ },
  \ "spec/factories/*.rb": {
  \   "command":   "factory",
  \   "affinity":  "collection",
  \   "alternate": "app/models/%i.rb",
  \   "related":   "db/schema.rb#%s",
  \   "test":      "spec/models/%i_test.rb",
  \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
  \   "keywords":  "factory sequence"
  \ },
  \ "app/finders/*_finder.rb": {
  \   "command":   "finder",
  \   "test":      "spec/finders/%i_spec.rb",
  \   "template":  "class %SFinder\n  def initialize\n  end\nend"
  \ },
  \ "app/services/*.rb": {
  \   "command":   "service",
  \   "test":      "spec/services/%i_spec.rb",
  \   "template":  "class %SService\n  def initialize\n  end\nend"
  \ },
  \ "app/models/concerns/*.rb": {
  \   "command":   "concern",
  \   "test":      "spec/model/concerns/%i_spec.rb",
  \   "template":  "module %S\n  extend ActiveSupport::Concern\n\n  included do\n    #something interesting\n  end\nend"
  \ },
  \ "app/jobs/*.rb": {
  \   "command":   "job",
  \   "test":      "spec/jobs/%i_spec.rb",
  \   "template":  "class %S\n  def initialize\n  end\nend"
  \ },
  \ "app/queries/*_query.rb": {
  \   "command":   "query",
  \   "affinity":  "collection",
  \   "test":      "spec/queries/%s_query_spec.rb",
  \   "template":  "class %SQuery\n  def initialize\n  end\nend"
  \ },
  \ "app/nulls/null_*.rb": {
  \   "command":   "null",
  \   "affinity":  "resource",
  \   "test":      "spec/nulls/null_%s_spec.rb",
  \   "template":  "class %S\n  def initialize\n  end\nend"
  \ },
  \ "spec/nulls/null_*_spec.rb": {
  \   "command":   "sn",
  \   "template":  "require 'spec_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/nulls/null_%s.rb",
  \   "keywords": "before describe context"
  \ },
  \ "app/workers/*_worker.rb": {
  \   "command":   "worker",
  \   "affinity":  "collection",
  \   "test":      "spec/workers/%i_spec.rb",
  \   "template":  "class %SWorker\n  def initialize\n  end\nend"
  \ },
  \ "app/policies/*_policy.rb": {
  \   "command":   "policy",
  \   "affinity":  "collection",
  \   "test":      "spec/policies/%i_spec.rb",
  \   "template":  "class %SPolicy\n  def initialize\n  end\nend"
  \ },
  \ "app/view_models/*_view.rb": {
  \   "command":   "view_model",
  \   "affinity":  "collection",
  \   "test":      "spec/view_models/%i_spec.rb",
  \   "template":  "class %SView\n  def initialize\n  end\nend"
  \ },
  \ "app/forms/*.rb": {
  \   "command":   "form",
  \   "affinity":  "collection",
  \   "test":      "spec/form/%i_spec.rb",
  \   "template":  "class %SForm\n  def initialize\n  end\nend"
  \ },
  \ "spec/views/*.haml_spec.rb": {
  \   "command":   "sv",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/views/%s.haml",
  \   "keywords": "before describe context"
  \ },
  \ "spec/views/*.html.haml_spec.rb": {
  \   "command":   "sv",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/views/%s.html.haml",
  \   "keywords": "before describe context"
  \ },
  \ "spec/views/*.html.erb_spec.rb": {
  \   "command":   "sv",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/views/%s.html.erb",
  \   "keywords": "before describe context"
  \ },
  \ "spec/views/*.xml.builder_spec.rb": {
  \   "command":   "sv",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/views/%s.xml.builder",
  \   "keywords": "before describe context"
  \ },
  \ "spec/finders/*_finder_spec.rb": {
  \   "command":   "sf",
  \   "alternate": "app/finders/%s.rb",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %SFinder do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/features/*_spec.rb": {
  \   "command":   "sfe",
  \   "template":  "require 'features_helper'\n\nRSpec.feature \'User intereacts\' do\n\nend",
  \   "keywords": "background given scenario"
  \ },
  \ "spec/models/*_spec.rb": {
  \   "command":   "sm",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %S do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/controllers/*_controller_spec.rb": {
  \   "command":  "sc",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SController do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/queries/*_query_spec.rb": {
  \   "command":  "sq",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SQuery do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/services/*_service_spec.rb": {
  \   "command":  "ss",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SService do\n\nend",
  \   "keywords": "before describe context"
  \ }
\ }

" invokes based on presence of gem in Gemfile
let g:rails_gem_projections = {
  \ "active_model_serializers": {
    \ "app/serializers/*_serializer.rb": {
      \ "command": "serializer",
      \ "affinity": "model",
      \ "test": "spec/serializers/%s_spec.rb",
      \ "related": "app/models/%s.rb",
      \ "template": "class %SSerializer < ActiveModel::Serializer\nend"
    \ }
  \ },
  \ "draper": {
  \   "app/decorators/*_decorator.rb": {
    \   "command": "decorator",
    \   "affinity": "model",
    \   "test": "spec/decorators/%s_spec.rb",
    \   "related": "app/models/%s.rb",
    \   "template": "class %SDecorator < Draper::Decorator\nend"
  \   }
  \ }
\ }
