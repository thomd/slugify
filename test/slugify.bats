setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
}

@test "can run slugify" {
    ./slugify
}

@test "escape filenames" {
    run ./slugify -n "My  File"
    assert_output --partial 'rename: My  File -> my__file'
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

