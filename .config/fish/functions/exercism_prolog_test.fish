function exercism_prolog_test
    set test_dir $(basename $PWD)
    swipl -t halt -g "[$test_dir]" -s {$test_dir}_tests.plt -g run_tests -- --all
end
