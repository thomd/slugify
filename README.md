# slugify

`slugify` is a bash command that converts filenames and directories to a web friendly format.

    > slugify

    usage: slugify [-acdhintuxv] source_file ...
       -a: remove spaces immediately adjacent to dashes
       -c: consolidate consecutive spaces into single space
       -d: replace spaces with dashes (instead of default underscores)
       -h: help
       -i: ignore case
       -n: dry run
       -t: treat existing dashes as spaces
       -u: treat existing underscores as spaces (useful with -a, -c, or -d)
       -x: remove special characters: ',()[]
       -v: verbose

## Why?

MacOS is **not case-sensitive**, meaning `File.txt` and `file.txt` are the **same file**. However some servers are case sensitive so problems can arise if the file
is used for a website. 

So, always avoid having filenames differentiated only by capitalisation.

Regarding **spaces**, they are not allowed in a URL and should also be avoided.

## Install

    git clone https://github.com/thomd/slugify.git
    cd slugify
    git submodule init
    git submodule update
    make test
    make install

You may set an **alias** for your preferred configuration, e.g.:

    alias slug="slugify -xca $@"

## Usage

Rename **files**:

    slugify My\ \ file.txt                               # my__file.txt
    slugify "My  file.txt"                               # my__file.txt
    slugify *.txt
    slugify "first file.txt" "second file.txt"

Rename **directories**:

    slugify "My Directory"                               # my_directory

**Dry run** with `-n` option:

    slugify -n *
    slugify -n "Ghost File.txt"                          # ghost_file.txt

Consolidate **multiple spaces** into **single space** with `-c` option:

    slugify -c "My    consolidated    file.txt"          # my_consolidated_file.txt

Replace spaces with dashes with `-d` option:

    slugify -d "My dashed file.txt"                      # my-dashed-file.txt
    slugify -d "My  dashed  file.txt"                    # my--dashed--file.txt
    slugify -dc "My  dashed  file.txt"                   # my-dashed-file.txt

Ignore case with `-i` option:

    slugify -i "UPPER CASE FILE.txt"                     # UPPER_CASE_FILE.txt

Remove special characters `'`, `(` or `)` with `-x` option:

    slugify -x "My Files (1).txt"                        # my_files_1.txt

Handle spaces adjacent to dashes with `-a` option:

    slugify "Beatles - Yellow Submarine.mp3"             # beatles_-_yellow_submarine.mp3
    slugify -a "Beatles - Yellow Submarine.mp3"          # beatles-yellow_submarine.mp3

    slugify -a "Beatles  -  Yellow Submarine.mp3"        # beatles__-__yellow_submarine.mp3
    slugify -ac "Beatles  -  Yellow Submarine.mp3"       # beatles-yellow_submarine.mp3

Convert underscores into dashes with `-u` option:

    slugify -ud "Spaces Dashes-And_Underscores.txt"      # spaces-dashes-and-underscores.txt

Convert dashes into underscores with `-t` option:

    slugify -t "Spaces Dashes-And_Underscores.txt"       # spaces_dashes_and_underscores.txt

