" Rails Projections -  help rails-projections

" `%s`: `{}` (Original)
" `%S`: `{camelcase|capitalize|colons}` (Ruby class name)
" `%S`: `{camelcase|capitalize|dot}` (JavaScript class name)
" `%p`: `{plural}`
" `%i`: `{singular}`
" `%h`: `{underscore|capitalize|blank}` - humanized
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
  \ "app/channels/*_channel.rb": {
  \   "command":   "channel",
  \   "affinity":  "resource",
  \   "test":      "spec/channel/%i_spec.rb",
  \   "template":  "# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.\nclass %SChannel < ApplicationCable::Channel\n  def subscribed\n    # stream_from \"some_channel\"\n  end\n\n  def unsubscribed\n    # Perform cleanup\n  end\n\n  def speak\n  end\nend"
  \ },
  \ "spec/channels/*channel_spec.rb": {
  \   "command":   "schannel",
  \   "template":  "require 'spec_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/channels/%s_channel.rb",
  \   "keywords": "before describe context"
  \ },
  \ "app/finders/*_finder.rb": {
  \   "command":   "finder",
  \   "test":      "spec/finders/%i_spec.rb",
  \   "template":  "class %SFinder\n  def initialize\n  end\nend"
  \ },
  \ "spec/finders/*_finder_spec.rb": {
  \   "command":   "sfinder",
  \   "alternate": "app/finders/%s.rb",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %SFinder do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "app/forms/*.rb": {
  \   "command":   "form",
  \   "affinity":  "collection",
  \   "test":      "spec/form/%i_spec.rb",
  \   "template":  "class %SForm\n  def initialize\n  end\nend"
  \ },
  \ "spec/forms/*_form_spec.rb": {
  \   "command":   "sform",
  \   "alternate": "app/forms/%s.rb",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %SForm do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/helpers/*_helper_spec.rb": {
  \   "command":   "shelp",
  \   "alternate": "app/helpers/%s.rb",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %SHelper do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "app/jobs/*.rb": {
  \   "command":   "job",
  \   "test":      "spec/jobs/%i_spec.rb",
  \   "template":  "class %S\n  def initialize\n  end\nend"
  \ },
  \ "app/models/concerns/*.rb": {
  \   "command":   "concern",
  \   "test":      "spec/model/concerns/%i_spec.rb",
  \   "template":  "module %S\n  extend ActiveSupport::Concern\n\n  included do\n    #something interesting\n  end\nend"
  \ },
  \ "app/nulls/*.rb": {
  \   "command":   "null",
  \   "affinity":  "resource",
  \   "test":      "spec/nulls/null_%s_spec.rb",
  \   "template":  "class Null%S\n  def initialize\n  end\nend"
  \ },
  \ "spec/nulls/*_spec.rb": {
  \   "command":   "snull",
  \   "affinity":  "resource",
  \   "template":  "require 'spec_helper'\n\nRSpec.describe Null%S do\n\nend",
  \   "alternate": "app/nulls/null_%s.rb",
  \   "keywords": "before describe context"
  \ },
  \ "app/policies/*_policy.rb": {
  \   "command":   "policy",
  \   "affinity":  "collection",
  \   "test":      "spec/policies/%i_policy_spec.rb",
  \   "template":  "class %SPolicy\n  def initialize\n  end\nend"
  \ },
  \ "spec/policies/*_policy_spec.rb": {
  \   "command":   "spolicy",
  \   "affinity":  "collection",
  \   "alternate": "app/policiies/%i_policy.rb",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SPolicy do\n\nend",
  \ },
  \ "app/presenters/*_presenter.rb": {
  \   "command":   "presenter",
  \   "affinity":  "collection",
  \   "test":      "spec/presenters/%i_spec.rb",
  \   "template":  "class %SPresenter\n  def initialize\n  end\nend"
  \ },
  \ "spec/presenters/*_presenter_spec.rb": {
  \   "command":  "spresenter",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SPresenter do\n\nend",
  \   "alternate": "app/presenters/%s.rb",
  \   "keywords": "before describe context"
  \ },
  \ "app/queries/*_query.rb": {
  \   "command":   "query",
  \   "affinity":  "collection",
  \   "test":      "spec/queries/%s_query_spec.rb",
  \   "template":  "class %SQuery\n  def initialize\n  end\nend"
  \ },
  \ "spec/queries/*_query_spec.rb": {
  \   "command":  "squery",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SQuery do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "app/services/*_service.rb": {
  \   "command":   "service",
  \   "test":      "spec/services/%i_spec.rb",
  \   "template":  "class %SService\n  def initialize\n  end\nend"
  \ },
  \ "spec/services/*_service_spec.rb": {
  \   "command":  "sservice",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SService do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "app/view_models/*_view.rb": {
  \   "command":   "view_model",
  \   "affinity":  "collection",
  \   "test":      "spec/view_models/%i_spec.rb",
  \   "template":  "class %SView\n  def initialize\n  end\nend"
  \ },
  \ "app/workers/*_worker.rb": {
  \   "command":   "worker",
  \   "affinity":  "collection",
  \   "test":      "spec/workers/%i_spec.rb",
  \   "template":  "class %SWorker\n  def initialize\n  end\nend"
  \ },
  \ "lib/tasks/*.rake": {
  \   "command":   "task",
  \   "affinity":  "resource",
  \   "alternate": "spec/lib/tasks/%s_rake_spec.rb",
  \   "test":      "spec/lib/tasks/%s_rake_spec.rb",
  \   "template":  "namespace :%i do\n desc '[description]'\n task something: :environment do\n end\nend",
  \   "keywords":  "namespace desc task"
  \ },
  \ "spec/lib/tasks/*_rake_spec.rb": {
  \   "command":  "stask",
  \   "template": "require 'rails_helper'\n\nRSpec.describe '%i:[task]' do\n  include_context 'rake'\n\nend",
  \   "alternate": "lib/tasks/%s.rake",
  \ },
  \
  \
  \
  \ "spec/controllers/*_controller_spec.rb": {
  \   "command":  "scontroller",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SController do\n\nend",
  \   "keywords": "before describe context"
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
  \ "spec/features/*_spec.rb": {
  \   "command":   "sfeature",
  \   "template":  "require 'features_helper'\n\nRSpec.feature \'User intereacts\' do\n\nend",
  \   "keywords": "background given scenario"
  \ },
  \ "spec/models/*_spec.rb": {
  \   "command":   "smodel",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe %S do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/routing/*_routing_spec.rb": {
  \   "command":  "sroute",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %SRouting do\n\nend",
  \   "keywords": "before describe context"
  \ },
  \ "spec/lib/*_spec.rb": {
  \   "command":   "slib",
  \   "affinity":  "resource",
  \   "alternate": "lib/%s_spec.rb",
  \   "template": "require 'rails_helper'\n\nRSpec.describe %S do\n\nend",
  \   "keywords":  "before describe context"
  \ },
  \ "spec/views/*.html.haml_spec.rb": {
  \   "command":   "sview",
  \   "template":  "require 'rails_helper'\n\nRSpec.describe \'%s\' do\n\nend",
  \   "alternate": "app/views/%s.html.haml",
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
