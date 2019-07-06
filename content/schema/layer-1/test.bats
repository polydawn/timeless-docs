#!/usr/bin/env bats

cd "$BATS_TEST_DIRNAME"

@test "example1.formula" {

	#[[ "$(cat example1.formula)" == "$(cat example1.formula | jq .)" ]] #
	### *actually* not canonical.  we tightened the bash lines, f.e.
	#printf "\n%q\n\n" "$(cat example1.formula)"
	#printf "\n%q\n\n" "$(cat example1.formula | jq .)"

	#[[ "$(cat example1.runrecord)" == "$(cat example1.runrecord | jq .)" ]]
	result="$(repeatr run example1.formula)"
	[ "$(echo "$result" | jq . > /dev/null; echo $?)" -eq 0 ]
	[ "$(cat example1.runrecord)" == "$result" ]
}
