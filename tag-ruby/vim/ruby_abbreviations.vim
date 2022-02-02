" How to: Type the letters then hit space

" General
iabbrev fsl # frozen_string_literal: true

" debugging
iabbrev bpry binding.pry
iabbrev bpid binding.pry if Rails.env.development?
iabbrev bpit binding.pry if Rails.env.test?
iabbrev brp binding.remote_pry
iabbrev brpid binding.remote_pry if Rails.env.development?
iabbrev brpit binding.remote.pry if Rails.env.test?

" RSpec
iabbrev af :aggregate_failures
