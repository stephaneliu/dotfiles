" How to: Type the letters then hit space

" General
iabbrev fsl # frozen_string_literal: true

" debugging
iabbrev bpa binding.pry
iabbrev bput binding.pry unless Rails.env.test?
iabbrev brp binding.remote_pry
iabbrev brput binding.remote_pry unless Rails.env.test?

" RSpec
iabbrev af :aggregate_failures
