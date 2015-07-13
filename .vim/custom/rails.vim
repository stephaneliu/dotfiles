" Rails Projections - 

" %s: original
" %S: camelized
" %p: pluralized
" %i: singulairized
" %h: humanized
"
" Affinity
" affinity: "collection" - Corresponds to plural
" affinity: "resource" - Corresponds to singular
" affinity: "model"
" affinity: "controller"
"
" globals
let g:rails_projections = {
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
  \   "test":      "spec/queries/%i_spec.rb",
  \   "template":  "class %SQuery\n def initialize \n end\nend"
  \ },
  \ "app/workers/*_worker.rb": {
  \   "command":   "worker",
  \   "affinity":  "collection",
  \   "test":      "spec/workers/%i_spec.rb",
  \   "template":  "class %SWorker\n def initialize \n end\nend"
  \ },
  \ "app/policies/*_policy.rb": {
  \   "command":   "policy",
  \   "affinity":  "collection",
  \   "test":      "spec/policies/%i_spec.rb",
  \   "template":  "class %SPolicy\n def initialize \n end\nend"
  \ },
  \ "app/view_models/*_view.rb": {
  \   "command":   "view_model",
  \   "affinity":  "collection",
  \   "test":      "spec/view_models/%i_spec.rb",
  \   "template":  "class %SView\n def initialize \n end\nend"
  \ },
  \ "app/forms/*.rb": {
  \   "command":   "form",
  \   "affinity":  "collection",
  \   "test":      "spec/form/%i_spec.rb",
  \   "template":  "class %SForm\n def initialize \n end\nend"
  \ },
  \ "spec/views/*.html.haml_spec.rb": {
  \   "command":   "sv",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/features/*_spec.rb": {
  \   "command":   "sf",
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
