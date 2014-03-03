book
=====

A ruby library and gem (soon) to compile text files into a book.

Based on http://chrismdp.com/2010/11/how-im-writing-my-book-using-git-and-ruby/

The idea here is to create an environment where snippets of a book can be
split and organized into many different files in sub-folders and such,
just like source code, and use a build file written in a convenient DSL to
build it all into a book, preferably resulting in a PDF, epub, etc.

This project will have two components:

  * Book DSL - a domain specific language to allow the user to specify
    where various sections of the book's text have been placed and how to
    compile them. This is first and will be significantly developed before
    the `book` gem (below) is worked on.

  * `book` gem - a ruby gem to compile a book using the Book DSL, manage
    revisions of book files, manage version control, generate statistics
    on the book and the writing process, etc.

## Book DSL

Every book, whether it's fiction or nonfiction, a dissertation or a novel,
a poetry collection or a picture book, has the same basic structure. That
said, different pieces tend to be more or less common, and which are
needed change based on the type of book.

  * Title Page [always]
  * Copyright Page [always, if it's published]
  * Table of Contents [usually]
  * Table of Figures [often in scientific literature]
  * Foreword [often]
  * Preface [often]
  * Prologue [occasionally]
  * Parts [often in fiction]
    * Chapters or Articles [nearly always]
      * Sections [often]
        * Subsections [sometimes]
          * ...
  * Epilogue [occasionally]
  * Afterword [occasionally]
  * Appendices [often in academic texts]

(Please note that the bracketed phrases above are not intended to
represent a full summary of every use of each node, but simply to indicate
the common use case for each and the frequency with which it is employed.)

Notice that above there are essentially two categories of sections:
  1. **Sections**: Those that are provided by the writer and can contain subsections
    * Foreward, Preface, Prologue
    * Parts, Chapters, Articles, Sections, Subsections, etc.
    * Epilogue, Afterword
    * Appendices
  2. **Metadata**: Those that are automatically generated based on book metadata and the
     other sections
    * Title Page
    * Copyright Page
    * Table of Contents, Table of Figures

The nice thing about these two broad categories is that, while some
formatting may change, the way you'd likely want to type it up is almost
identical within each category. More specifically, the first category
(Sections) is nearly identical, and the second category (Metadata) shouldn't have to
be directly dealt with by the user at all.

### Sections

Thinking in terms of software, Sections seem like a pretty good candidate
for a simple class hierarchy. Really, all we need is a common base class
and a bunch of basically empty classes that inherit from it, with perhaps
some minor changes here and there.

See the [[TODO.md]] file for details of all the anticipated features.

## `book` gem

Functions:
  * `compile [<bookfile>] [-h | -p | -e]` - compile a directory and its
    subdirectory contents into a book. If `<bookfile>` is specified, use
    it; otherwise, look for a file called `Bookfile` (or some case-
    variant thereon).

  * `revise <section>` - open an editor with a copy of `<section>` tagged
    as a draft. 
      Aside: Should the book gem maintain a file structure for revisions
      and drafts of various section files? This likely wouldn't be too
      difficult.
  
  * `stats` - generate and display a statistics report, containing such
    items as:
      - words-per-day since beginning this book
      - top ten most common words, excluding trivials, e.g. a, an, and, the, ...
      - preferred writing hours? (might be tough to calculate; maybe
        monitor files for changes on disk? would require a long running
        process... needs more thought)
  
  * `commit <message>` - commit book to github

## Usage

[**Good news everyone!**](http://allassistedlivinghomes.com/assisted-living-news/wp-content/uploads/2011/04/good_news_everyone.png)

`book v0.1` has been released. This is the result of about a week of spare-time hacking,
and as such it's anything but complete. However, it is relatively useful if you want
to jump in right now!

**To use:**

  1. Check out the repo:

         git pull http://github.com/kenbellows/book.git
         cd book/src

  2. Try an example! I've put together a pretty thorough example using Cory Doctorow's
     [*Little Brother*](http://craphound.com/littlebrother/download/), which he has
     released under the [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 license](http://creativecommons.org/licenses/by-nc-sa/3.0/),
     meaning guys like me can make use of it as long as I let you know where I got it.
     
     At any rate, the example makes use of pretty much every feature available under
     `book` at the moment. To compile, simply run the following command from the `book/src`
     directory:

         ruby book.rb ../examples/little_brother/bookfile.rb > little_brother.md
     
     Note two things: First, if there's no `bookfile.rb` in the current directory,
     one must be pointed to elsewhere. Second, currently, `book` **only properly ingests
     and outputs Markdown**. This will hopefully change soon.
