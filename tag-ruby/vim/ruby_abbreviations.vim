" Binding Pry All
iabbrev bpa binding.pry
" Binding Pry Except Test
iabbrev bpet binding.pry unless Rails.env.test?
