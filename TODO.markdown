TODO List
==========

1. Sections
  * `Section` base class
    * takes a title argument; if it's an empty string, just displays number
    * supports such subelements as `Part`, `Chapter`, `Article`, `Section`, etc. 
    * maybe each subclass should have a way to specify allowed descendants
    * can take a file, a block that returns a string with text, more Section
      children, or a combination; the string method is especially good for
      short sections, e.g. the Dedication
  * Subclasses of `Section`
    * `Part` - top level container
    * `Chapter` and `Article` - top level container, or contained within `Part`
    * Labelled Sections - top level section with a label, no number, and only
      `Section` descendants. This is the class to be used for such sections as:
      * Preface
      * Prologue
      * Epilogue
      * Afterword
      * Appendix
      I think these and some other common names for sections (Introduction,
      Foreword, Prelude, etc) should be added. They are 1 line of code each,
      and it looks so much prettier to put `introduction do ... end` than
      `section "introduction" do ... end`.
2. Metadata
  * Title page - composed by methods:
    * `author`
    * `dedication`
    * `image`
  * Publisher page
    * `publisher` method - submethods:
      * `name` - if self-published, this can be the author's own name;
        otherwise, can be name of publishing firm
      * `address` - street address of publisher, email address of self-published
        author, etc.
      * `license` - Two typical uses, and a fallback:
        1. Digital License, e.g. Creative Commons; in this case, a second arg
          with a link to a hosted copy of the link is allowed. Any text is
          allowed here. If it's not recognized as a known license, it will
          simply be faithfully reproduced.
          * Feature Idea: auto-parse CC abbreviations and add CC-3.0 links;
            could do the same with, e.g., GPL, LGPL, MIT, Apache, ...
        2. Use the symbol `:all_rights_reserved` to generate the standard "All
          Rights Reserved" text:
          * "All rights reserved, including the right to reproduce this book, or
            portions thereof, in any form."
      * `years` - uses `*args` to accept an arbitrary number of copyright years
        * If ommitted, the current year will be used
  * Dedication page
    * `dedication` method - acts like a Section, but does not take children
  * Table of Contents
    * `table_of_contents method takes an optional symbol argument representing
      what kind of outline it should create
      * `:all` - default; all parts, chapters, and sections listed
      * `:chapters` - only show chapters and above
      * `:articles` - only show articles and above. Formatted a bit differently
        than chapters: no numbers, just names
3. Formatting
  Some top level formatting will be allowed.
  * `assume <ext>` - when not provided, assume all Files have the file extension
    `<ext>`
  * `produce <ext>` - specify the default ouput when building into a book. This
    will be overrideable at command line.
  * `paper do ... end` - specify paper formatting options
    * `size` - specify such standard paper sizes as :a4, :letter, :legal, etc.
      Default will be letter (becuase I'm an American developer and I'm self-
      centered, I guess). **This option only works when producing pdf.**
    * `margins` - specify margn width as `margins <horizontal> <vertical>`
  * `fonts do ... end` - specofy fonts for various elements
    * headings
    * body
    * title page
    Should this be a universally embeddable thing? Change the fonts of a
    particular section?

