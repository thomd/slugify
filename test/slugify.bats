setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
}

@test "can run slugify" {
    ./slugify
}

@test "escape filenames" {
    run ./slugify -n "My  File.txt"
    assert_output --partial "rename: My  File.txt -> my__file.txt"
}

@test "remove special characters" {
    run ./slugify -n -x "My F'ile.txt"
    assert_output --partial "rename: My F'ile.txt -> my_file.txt"
    run ./slugify -n -x "My File (1).txt"
    assert_output --partial "rename: My File (1).txt -> my_file_1.txt"
}

@test "consolidate consecutive spaces into single spaces" {
    run ./slugify -n -c "My    consolidated    file.txt"
    assert_output --partial 'rename: My    consolidated    file.txt -> my_consolidated_file.txt'
}

@test "replace spaces with dashes" {
    run ./slugify -n -d "My dashed file.txt"
    assert_output --partial 'My dashed file.txt -> my-dashed-file.txt'
    run ./slugify -n -d "My  dashed  file.txt"
    assert_output --partial 'My  dashed  file.txt -> my--dashed--file.txt'
    run ./slugify -n -d -c "My  dashed  file.txt"
    assert_output --partial 'My  dashed  file.txt -> my-dashed-file.txt'
}

@test "ignore case" {
    run ./slugify -n -i "UPPER CASE FILE.txt"
    assert_output --partial 'UPPER CASE FILE.txt -> UPPER_CASE_FILE.txt'
}

@test "handle spaces adjacent to dashes" {
    run ./slugify -n -a "The Beatles - Yellow Submarine.mp3"
    assert_output --partial 'The Beatles - Yellow Submarine.mp3 -> the_beatles-yellow_submarine.mp3'
    run ./slugify -n -a -c "The Beatles   -   Yellow Submarine.mp3"
    assert_output --partial 'The Beatles   -   Yellow Submarine.mp3 -> the_beatles-yellow_submarine.mp3'
}

@test "convert existing underscores into dashes" {
    run ./slugify -n -u -d "Spaces Dashes-And_Underscores.txt"
    assert_output --partial 'Spaces Dashes-And_Underscores.txt -> spaces-dashes-and-underscores.txt'
}

@test "convert existing dashes into underscores" {
    run ./slugify -n -t "Spaces Dashes-And_Underscores.txt"
    assert_output --partial 'Spaces Dashes-And_Underscores.txt -> spaces_dashes_and_underscores.txt'
}

