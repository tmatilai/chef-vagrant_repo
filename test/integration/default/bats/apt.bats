#!/usr/bin/env bats

@test "installs front page" {
run wget -q -O - http://$(hostname -f)/
    [ "$status" -eq 0 ]
    [[ "$output" == *"Apt Repository"* ]]
}
