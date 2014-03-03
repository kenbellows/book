book "Little Brother" do
  assume 'md'

  author "Cory Doctorow"
  softcopy = true
  publisher do
    if softcopy
      name    "Cory Doctorow"
      address "doctorow@craphound.com"
      license :cc_by_nc_sa # CC Attr-NonComm-ShareAlike 4.0
    else
      name    "Tom Doherty Associates, LLC"
      address "175 Fifth Avenue, New York, NY 10010"
      years   2008
      license :all_rights_reserved
    end
  end

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
  section "quotes", :file => "intro/quotes"

  # Now for the good stuff
  chapter do
    dir 'chapters/1'

    # Mr. Doctorow has dedicated his individual chapters,
    # each to a different bookstore that made an impact on.
    # him. A bit unconventional in books, and not explicitly
    # supported, but still doable. And pretty great.
    file 'dedication'

    file 'scenes/w1n5t0n'
    file 'scenes/benson'
    file 'scenes/harajuku'
    file 'snippets/arglarp'
    file 'snippets/gaitrecog'
    file 'scenes/clue/p1'
    file 'scenes/clue/p2'
  end

  chapter do
    dir 'chapters/2'
    file 'dedication'
    
    file 'scenes/nuke'
    file 'scenes/charles'
    file 'scenes/thecrew'
    file 'scenes/clue'
    file 'scenes/earthquake'
  end

  # ... Many more chapters... you get the idea
end
