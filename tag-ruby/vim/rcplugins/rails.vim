" Rails Projections -  help rails-projections

" `%s`: `{}` (Original)
" `{camelcase|capitalize|colons}` (Ruby class name)
" `{camelcase|capitalize|dot}` (JavaScript class name)
" `{plural}`
" `{singular}`
" `{underscore|capitalize|blank}` - humanized
"
" Affinity
" affinity: "collection" - Corresponds to plural
" affinity: "resource" - Corresponds to singular
" affinity: "model"
" affinity: "controller"
"
" globals
let g:rails_projections = {
  \ "app/javascript/controllers/*": {
  \   "command":   "stimulus",
  \ },
  \ "config/*": {
  \   "command":   "config"
  \ },
  \ "config/database.yml": {
  \   "command":   "database"
  \ },
  \ "Guardfile": {
  \   "command":   "guard"
  \ },
  \ "app/adapters/*_adapter.rb": {
  \   "command":   "adapter",
  \   "test":      "spec/adapters/{singular}_spec.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Adapter",
  \     "  def initialize",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/adapters/*_adapter_spec.rb": {
  \   "command":   "sadapter",
  \   "alternate": "app/adapters/%s.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"spec_helper\"",
  \     "",
  \     "RSpec.describe {camelcase|capitalize|colons}Adapter do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/channels/*_channel.rb": {
  \   "command":   "channel",
  \   "affinity":  "resource",
  \   "test":      "spec/channel/{singular}_spec.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "# Be sure to restart your server when you modify this file.",
  \     "# Action Cable runs in a loop that does not support auto reloading.",
  \     "class {camelcase|capitalize|colons}Channel < ApplicationCable::Channel",
  \     "  def subscribed",
  \     "    # stream_from \"some_channel\"",
  \     "  end",
  \     "",
  \     "  def unsubscribed",
  \     "    # Perform cleanup",
  \     "  end",
  \     "",
  \     "  def speak",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/channels/*channel_spec.rb": {
  \   "command":   "schannel",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"spec_helper\"",
  \     "",
  \     "RSpec.describe \'%s\' do",
  \     "end"
  \   ],
  \   "alternate": "app/channels/%s_channel.rb",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/finders/*_finder.rb": {
  \   "command":   "finder",
  \   "test":      "spec/finders/{singular}_spec.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Finder",
  \     "  def initialize",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/finders/*_finder_spec.rb": {
  \   "command":   "sfinder",
  \   "alternate": "app/finders/%s.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe {camelcase|capitalize|colons}Finder do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/forms/*_form.rb": {
  \   "command":  "form",
  \   "affinity": "collection",
  \   "test":     "spec/form/{singular}_spec.rb",
  \   "template": [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Form",
  \     "  def initialize",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/forms/*_form_spec.rb": {
  \   "command":   "sform",
  \   "alternate": "app/forms/%s.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe {camelcase|capitalize|colons}Form do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/graphql/fields/*_type.rb": {
  \   "command":   "gfield",
  \   "affinity":  "collection",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module Fields\n  class {camelcase|capitalize|colons}Type < GraphQL::Scalar::Scalar\n    end\n    graphql_name 'CHANGEME'\n\n  end\nend"
  \   ],
  \ },
  \ "app/graphql/mutations/*_mutation.rb": {
  \   "command":  "gmutation",
  \   "affinity": "collection",
  \   "related":  "app/graphql/mutations/base_mutation.rb",
  \   "test":     "spec/graphql/mutations/{singular}_mutation_spec.rb",
  \   "template": [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module Mutations",
  \     "  class {camelcase|capitalize|colons}Mutation < BaseMutation",
  \     "    graphql_name '{camelcase|capitalize|colons}'",
  \     "    description 'REPLACE THIS'",
  \     "",
  \     "    def resolve()",
  \     "      if result.success?",
  \     "        {",
  \     "          SOMETHING: result.SOMETHING,",
  \     "          errors: []",
  \     "        }",
  \     "      else",
  \     "        {",
  \     "          SOMETHING: nil,",
  \     "          errors: errors_for_record(result)",
  \     "        }",
  \     "      end",
  \     "    end",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/graphql/mutations/*_mutation_spec.rb": {
  \   "command":   "sgmutation",
  \   "alternate": "app/graphql/mutations/{singular}_mutation.rb",
  \   "template":  [
  \   "# frozen_string_literal: true",
  \   "",
  \   "require \"rails_helper\"",
  \   "",
  \   "RSpec.describe Mutations::{camelcase|capitalize|colons}Mutation, type: :graphql do",
  \   "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/graphql/inputs/*_input.rb": {
  \   "command":   "ginput",
  \   "affinity":  "collection",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module ReplaceMeNamespace",
  \     "  class {camelcase|capitalize|colons}Type < BaseInput",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/graphql/inputs/*_input_spec.rb": {
  \   "command":   "sginput",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe CompanyCamSchema do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/graphql/company_cam_schema.rb": {
  \   "command":   "gschema"
  \ },
  \ "app/graphql/types/*_type.rb": {
  \   "command":  "gtype",
  \   "affinity": "collection",
  \   "template": [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module Types",
  \     "  class {camelcase|capitalize|colons}Type < BaseObject",
  \     "    graphql_name '{camelcase|capitalize|colons}'",
  \     "    description 'REPLACE THIS'",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/graphql/types/*_type_spec.rb": {
  \   "command":   "sgtype",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe CompanyCamSchema, type: :graphql do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/graphql/enums/*_enum.rb": {
  \   "command":   "genum",
  \   "affinity":  "collection",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module Enums",
  \     "  class {camelcase|capitalize|colons}Enum < BaseEnum",
  \     "    graphql_name '{camelcase|capitalize|colons}'",
  \     "    description 'REPLACE THIS'",
  \     "    value('NAME', 'DESCRIPTION', value: :optional_corresponding_ruby_attribute)",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/helpers/*_helper_spec.rb": {
  \   "command":   "shelp",
  \   "alternate": "app/helpers/%s.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe {camelcase|capitalize|colons}Helper do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/interactors/*_interactor.rb": {
  \   "command":   "interactor",
  \   "affinity":  "collection",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "module SOMEMODULE",
  \     "  class {camelcase|capitalize|colons}Interactor",
  \     "    include Interactor",
  \     "",
  \     "    delegate :some, :thing, to: :context",
  \     "",
  \     "    def call",
  \     "    end",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/interactors/*_interactor_spec.rb": {
  \   "command":   "sinteractor",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "class {camelcase|capitalize|colons}Interactor",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/jobs/*.rb": {
  \   "command":   "job",
  \   "test":      "spec/jobs/{singular}_spec.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Job",
  \     "  include Sidekiq::Worker",
  \     "",
  \     "  sidekiq_options queue: '[CHANGE_QUEUE]', retry: [CHANGE_RETRY]",
  \     "",
  \     "  def perform(ARGS)",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/jobs/*_job_spec.rb": {
  \   "command":   "sjob",
  \   "alternate": "app/jobs/{singular}.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Job",
  \     "  def initialize",
  \     "  end",
  \     "end"
  \   ],
  \ },
  \ "app/reports/*.rb": {
  \   "command":   "report",
  \   "affinity":  "collection",
  \   "test":      "spec/reports/{singular}_spec.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "class {camelcase|capitalize|colons}Report",
  \     "  def initialize",
  \     "  end",
  \     "end"
  \   ]
  \ },
  \ "spec/reports/*_report_spec.rb": {
  \   "command":   "sreport",
  \   "alternate": "app/reports/{singular}.rb",
  \   "template":  [
  \     "# frozen_string_literal: true",
  \     "",
  \     "require \"rails_helper\"",
  \     "",
  \     "RSpec.describe {camelcase|capitalize|colons}Report do",
  \     "end"
  \   ],
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/models/concerns/*.rb": {
  \   "command":   "concern",
  \   "test":      "spec/model/concerns/{singular}_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nmodule {camelcase|capitalize|colons}\n  extend ActiveSupport::Concern\n\n  included do\n    #something interesting\n  end\nend"
  \ },
  \ "app/nulls/*.rb": {
  \   "command":   "null",
  \   "affinity":  "resource",
  \   "test":      "spec/nulls/null_%s_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass Null{camelcase|capitalize|colons}\n  def initialize\n  end\nend"
  \ },
  \ "spec/nulls/*_spec.rb": {
  \   "command":   "snull",
  \   "affinity":  "resource",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"spec_helper\"\n\nRSpec.describe Null{camelcase|capitalize|colons} do\n\nend",
  \   "alternate": "app/nulls/null_%s.rb",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/pages/*_page.rb": {
  \   "command":   "page",
  \   "affinity":  "resource",
  \   "test":      "spec/pages/{}_page_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Page\n  def initialize\n  end\nend"
  \ },
  \ "spec/pages/*_spec.rb": {
  \   "command":   "spage",
  \   "affinity":  "resource",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"spec_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Page do\n\nend",
  \   "alternate": "app/nulls/null_%s.rb",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/policies/*_policy.rb": {
  \   "command":   "policy",
  \   "affinity":  "collection",
  \   "test":      "spec/policies/{singular}_policy_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Policy\n  def initialize\n  end\nend"
  \ },
  \ "spec/policies/*_policy_spec.rb": {
  \   "command":   "spolicy",
  \   "affinity":  "collection",
  \   "alternate": "app/policiies/{singular}_policy.rb",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Policy do\n\nend",
  \ },
  \ "app/presenters/*_presenter.rb": {
  \   "command":   "presenter",
  \   "affinity":  "collection",
  \   "test":      "spec/presenters/{singular}_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Presenter\n  def initialize\n  end\nend"
  \ },
  \ "spec/presenters/*_presenter_spec.rb": {
  \   "command":  "spresenter",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Presenter do\n\nend",
  \   "alternate": "app/presenters/%s.rb",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/queries/*_query.rb": {
  \   "command":   "query",
  \   "affinity":  "collection",
  \   "test":      "spec/queries/%s_query_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Query\n  def initialize\n  end\nend"
  \ },
  \ "spec/queries/*_query_spec.rb": {
  \   "command":  "squery",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Query do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/services/*.rb": {
  \   "command":   "service",
  \   "test":      "spec/services/{singular}_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}\n  def initialize\n  end\nend"
  \ },
  \ "spec/services/*_spec.rb": {
  \   "command":  "sservice",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons} do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "spec/support/*.rb": {
  \   "command":  "ssupport",
  \   "template": "# frozen_string_literal: true\n\nRSpec.configure do |config|\nend"
  \ },
  \ "spec/system/*_spec.rb": {
  \   "command":  "ssystem",
  \   "template": "# frozen_string_literal: true\n\nrequire \"features_helper\"\n\nRSpec.describe \"{capitalize}\" do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "app/view_models/*_view.rb": {
  \   "command":   "view_model",
  \   "affinity":  "collection",
  \   "test":      "spec/view_models/{singular}_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}View\n  def initialize\n  end\nend"
  \ },
  \ "app/workers/*_worker.rb": {
  \   "command":   "worker",
  \   "affinity":  "collection",
  \   "test":      "spec/workers/{singular}_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Worker\n  def initialize\n  end\nend"
  \ },
  \ "lib/tasks/*.rake": {
  \   "command":   "task",
  \   "affinity":  "resource",
  \   "alternate": "spec/lib/tasks/{}_rake_spec.rb",
  \   "test":      "spec/lib/tasks/{}_rake_spec.rb",
  \   "template":  "# frozen_string_literal: true\n\nnamespace :{} do\n  desc \"[description]\"\n  task something: :environment do\n  end\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "spec/lib/tasks/*_rake_spec.rb": {
  \   "command":  "stask",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\nrequire \"rake\"\n\nRSpec.describe \"{}:[task]\" do\n  include_context 'rake'\n\nend",
  \   "alternate": "lib/tasks/{}.rake",
  \ },
  \ "spec/controllers/*_controller_spec.rb": {
  \   "command":  "scontroller",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Controller do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "from", "fspecify", "let", "let!", "to"]
  \ },
  \ "spec/factories/*.rb": {
  \   "command":   "factory",
  \   "affinity":  "collection",
  \   "alternate": "app/models/{singular}.rb",
  \   "related":   "db/schema.rb#%s",
  \   "test":      "spec/models/{singular}_test.rb",
  \   "template":  "# frozen_string_literal: true\n\nFactoryGirl.define do\n  factory :{singular} do\n  end\nend",
  \   "rubyMacro": ["factory", "sequence"]
  \ },
  \ "spec/features/*_spec.rb": {
  \   "command":   "sfeature",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"features_helper\"\n\nRSpec.feature \'User intereacts\' do\n\nend",
  \   "rubyMacro": ["background", "given", "scenario"]
  \ },
  \ "spec/models/*_spec.rb": {
  \   "command":   "smodel",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons} do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "fspecify", "let", "let!"]
  \ },
  \ "spec/routing/*_routing_spec.rb": {
  \   "command":  "sroute",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons}Routing do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "fspecify", "let", "let!"]
  \ },
  \ "spec/lib/*_spec.rb": {
  \   "command":   "slib",
  \   "affinity":  "resource",
  \   "alternate": "lib/%s_spec.rb",
  \   "template": "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe {camelcase|capitalize|colons} do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "fspecify", "let", "let!"]
  \ },
  \ "spec/views/*.html.haml_spec.rb": {
  \   "command":   "sview",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe \"{}.html.haml\", type: :view do\n\nend",
  \   "alternate": "app/views/%s.html.haml",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "fspecify", "let", "let!"]
  \ },
  \ "spec/requests/*_spec.rb": {
  \   "command":   "srequest",
  \   "template":  "# frozen_string_literal: true\n\nrequire \"rails_helper\"\n\nRSpec.describe \'{}\' do\n\nend",
  \   "rubyMacro": ["after", "before", "describe", "context", "fdescribe", "fcontext", "fit", "fspecify", "let", "let!"]
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
      \ "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Serializer < ActiveModel::Serializer\nend"
    \ }
  \ },
  \ "draper": {
  \   "app/decorators/*_decorator.rb": {
    \   "command": "decorator",
    \   "affinity": "model",
    \   "test": "spec/decorators/%s_spec.rb",
    \   "related": "app/models/%s.rb",
    \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Decorator < Draper::Decorator\nend"
  \   }
  \ }
\ }
