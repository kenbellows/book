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
    text 'To all you awesome people that read this.'
  end

  chapter 'f1r57!' do
    text "This is some really simple sample text to demonstrate how a chapter\
          can look. Don't think this is all you can do. It's just a sample."
    file 'chapters/1/body'
  end

  chapter '53c0nd!' do
    dir 'chapters/2'
    file 'you_get_it'
    file 'dont_you'
  end

  # ... I think you get the idea
end
