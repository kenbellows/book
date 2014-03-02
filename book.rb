#!/usr/bin/ruby

class Section
  attr_accessor :files, :contents, :ext
  def initialize title, opts={}, &block
    @title_str = title
    # TODO if no @_file and no @text, set @_file = "sections/#{title.downcase.gsub(/\W+/, '_')}
    @ext       = opts[:ext]      || nil
    @text      = opts[:text]     || nil
    @level     = opts[:level]    || nil
    @parent    = opts[:parent]   || nil
    @subtitle  = opts[:subtitle] || nil
    @contents  = []
    @files     = []
    file opts[:file] if opts.has_key?(:file)
    
    # Hang on to the current directory
    pwd = Dir.pwd
    instance_eval &block if block_given?
    # If we moved around during the block, move back to where we were
    Dir.chdir pwd
  end

  def do_block &block
    # Hang on to the current directory
    pwd = Dir.pwd
    instance_eval &block if block_given?
    # If we moved around during the block, move back to where we were
    Dir.chdir pwd
  end

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
  
  # Expect a particular filetype, e.g. to assume markdown files,
  # use `assume "md"`. This extension will be ignore
  # if the filename matches the regex /\.\w+$/, i.e. it looks
  # like it already has an extension
  def assume ext
    if ext.start_with? '.'
      @ext = ext.downcase
    else
      @ext = '.'+ext.downcase
    end
  end

  # Make this Section object the root of the document;
  # This should only be called once, and only if an
  # already-top-level element is not being used, as it
  # *will* overwrite the existing root element
  def root
    $Root = self
  end

  # Add a file's contents to @contents
  def file f
    # Add a placeholder in @contents where it needs to go
    #@contents.push :fileholder

    # If the object provided is not a File object, treat it as a String,
    # assume it is a filepath, and use it to open a new File object
    unless f.is_a? File
      filename = f.to_s
      filename += @ext unless filename.downcase.match /\.\w+$/ if @ext
      #puts "pwd: #{Dir.pwd}"
      f = File.new filename
    end
    # Read in the file and add the resulting string to @contents
    @contents.push f.read
  end

  # Insert a bit of raw text at the current position
  def text t
    @contents.push t
  end

  # Take care of any logistics necessary before compiling
  def precompile
  end

  # Compile @contents into a block of Markdown
  def simple_compile level=nil
    precompile

    # If no level is explicity provided, first check whether a level
    # was provided at initialization; if not, assume this is a top-level
    # element (i.e. level=1)
    unless level
      level = @level? @level : 1
    end

    # Put together a list of strings representing all the little bits
    # of the final file
    bits = []
    # If we've got a title, start with the title
    bits.push "#{'#'*level} #{@title_str}" if @title_str
    
    # If we've got a text element, that goes first
    bits.push @text if @text
    @contents.each do |sec|
      case sec
        # If this section is a File object, read it
        when File
          bits.push sec.read
        # If this section is a Section, recurse and get its contents
        when Section
          bits.push sec.simple_compile(level+1)
        # Otherwise, coerce this object into a String (it's probably
        # already a String anyway)
        else
          bits.push sec.to_s
        end
    end

    # Return the sum of all parts, separated by the Markdown-standard
    # double newline
    bits.join "\n\n"
  end

  
  def self.allow_subsection section_type
    method_name = nil
    if section_type.is_a? Class
      subsection = section_type
      method_name = section_type.to_s.gsub(/(.)([A-Z]+)/, '\1_\2'.downcase).downcase
    else
      subsection = Object::const_get(section_type.to_s)
      method_name = section_type.downcase
    end
    define_method method_name do |*args, &block|
      if args.first.is_a? Hash
        args.unshift ""
      elsif args.first.is_a? NilClass
        args[0] = ""
      end
      if args.last.is_a? Hash
        args.last[:ext]    = @ext
        args.last[:parent] = self
      else
        args.push({:ext => @ext, :parent => self})
      end
      s = subsection.new *args, &block
      @contents.push s
    end
  end
  def self.subsections section_list
    section_list.each {|sectype| self.allow_subsection sectype }
  end

  # When defining a subclass of section, in order to allow more than just
  # Section children, call self.subsections on a list of allowed subsections,
  # e.g. self.subsections [Introduction, Part, Chapter, Section]
  #
  # This is untested as of now, but it should be such that when you define
  # a subclass of a Section type, you only need to call self.subsections on
  # the types not already allowed by the superclass and its ancestors
  self.subsections ['Section']
end

class NamedSection < Section
  def initialize title=nil, opts={}, &block
    super title || self.class.to_s, opts, &block
  end
end


# Section subtypes; these can only support Section children, and they
# don't take a title; instead they use the class name itself
[ "Dedication", "Foreword", "Preface", "Prologue", "Introduction", 
  "Epilogue", "Afterword", "Appendix" ].each do |sectype|
  s = Class.new NamedSection
  Kernel.const_set sectype, s

end

class Chapter < Section
  def initialize *args, &block
    super
    @parent.chapter_num += 1
    @num = @parent.chapter_num
  end
  def title t
    if t
      super
    else
      "Chapter #{@num}: #{@title_str}"
    end
  end
  def precompile
    @title_str = "Chapter #{@num}" + (@title_str&&@title_str.length>0? ": #{@title_str}" : "")
  end
end

class Article < Section
  attr_accessor :chapter_num
  def initialize title, opts={}, &block
    @author = opts.has_key?(:author) ? opts[:author] : nil
    @chapter_num = 0
    super
    $Root = self unless $Root
  end

  def author au=nil
    if au
      @author = au
    else
      @author
    end
  end

  self.subsections ['Chapter']
end

class Part < Section
  attr_accessor :chapter_num
  def initialize *args, &block
    super
    @chapter_num = 0
  end
  self.subsections ['Introduction', 'Article', 'Chapter', 'Section']
end




# This is the big guy
class Book < Article
  attr_accessor :chapter_num
  def initialize *args, &block
    super
    $Root = self
  end

  def precompile
    @title_str += ": #{@subtitle}" if @subtitle
  end

  self.subsections [
    'Introduction', 'Dedication', 'Foreword', 'Preface', 'Prologue',
    'Part', 'Chapter',
    'Epilogue', 'Afterword', 'Appendix'
  ]
end

def book *args, &block
  Book.new *args, &block
end
def article *args, &block
  Article.new *args, &block
end


# Allow this file to work as a script
if __FILE__ == $0
  bookfile = ARGV[0]
  unless bookfile
    begin
      Dir['./*'].each do |filename|
        if filename.downcase.split('/').last == 'bookfile.rb'
          bookfile = filename
          break
        end
      end
    end
  else
    unless bookfile.start_with? '/' or bookfile.start_with? './'
      bookfile = './'+bookfile
    end
  end
  unless bookfile
    puts  "Usage: #{$0} [<bookfile>]"
    print "    If no <bookfile> is provided, a file named 'Bookfile.rb'"
    puts  " (case insensitive) must be present in the current directory."
    exit 1
  end

  $Root = nil
  require bookfile

  if $Root
    puts $Root.simple_compile
  else
    puts "ERROR: Could not find a valid top-level construct"
  end
    
end
