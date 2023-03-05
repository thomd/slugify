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
