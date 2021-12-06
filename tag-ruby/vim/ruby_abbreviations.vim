" How to: Type the letters then hit space

" General
iabbrev fsl # frozen_string_literal: true

" debugging
iabbrev bpry binding.pry
iabbrev bpid binding.pry if Rails.env.development?
iabbrev brp binding.remote_pry
iabbrev brpid binding.remote_pry if Rails.env.development?

" RSpec
iabbrev af :aggregate_failures
