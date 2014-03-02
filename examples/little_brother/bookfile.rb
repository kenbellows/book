book "Little Brother" do
  assume 'md'

  author "Cory Doctorow"
  softcopy = true
  publisher do
    if softcopy
      name    "Cory Doctorow"
      address "doctorow@craphound.com"
      license "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported", "http://creativecommons.org/licenses/by-nc-sa/3.0/"
    else
      name    "Tom Doherty Associates, LLC"
      address "175 Fifth Avenue, New York, NY 10010"
      years   2008
      license :all_rights_reserved
  end

  table_of_contents :chapters

  # Shockingly long intro (come on Cory)
  introduction do
    file "intro/intro"

    section "Do Something",                     :file => "intro/dosomething"
    section "Great Britain",                    :file => "intro/greatbritain"
    section "Other Edition",                    :file => "intro/othereditions"
    section "The Copyright Thing",              :file => "intro/copyright"
    section "Donations and a Word to Teachers", :file => "intro/donationsandteachers"
  end
  dedication do
    "For Alice, who makes me whole"
  end
  section "quotes", :file => "introduction/quotes"

  # Now for the good stuff
  chapter do
    dir 'chapters/1'

    # Mr. Doctorow has dedicated his individual chapters.
    # A bit unconventional, but still doable.
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
