## Sample Section

This section was included within a markdown file.

Note that in order for the heading to be at the proper level, I had to
make sure that I manually included the right number of `#` characters at
the beginning of the heading line.


## This is Another Section

Just to show it in action, here's some code!

    def subtitle st=nil
      if st
        @subtitle = st
      else
        @subtitle
      end
    end

    def dir d
      Dir.chdir d
    end

