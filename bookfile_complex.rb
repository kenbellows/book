# TOP


book 'Test Book' do
  assume 'md'

  subtitle 'This one\'s the Testyist of All'
  author 'Ken Bellows'

  introduction do
    dir 'intro'

    file 'introduction'
    section 'Inspiration', :file => 'inspiration'
    section 'License Stuff', :file => 'license'
  end

  dedication do
    'For Alice, who makes me whole'
  end

  section 'quotes', :file => 'quotes'

  # Now for the good stuff
  chapter do
    dir 'chapters/1'
    file 'dedication'
    file 'scenes/w1n5t0n'
    file 'scenes/benson'
    file 'scenes/harajuku'
    file 'snippets/arglarp'
    file 'scenes/gaitrecog'
  end

  chapter do
    dir 'chapters/2'
    file 'dedication'
    file 'scenes/arphid'
    # ... I thiknk you get the idea
  end

  # ... Many more chapters
end
