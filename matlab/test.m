%% test:
% Runs each test in the current folder and includes files from the src
% folder before running them
function [result] = test(ci)
    if (nargin < 1)
        ci = false;
    end

    try
        p = addpath(pwd);
        results = run_tests();
    catch e
        path(p);
        disp(getReport(e,'extended'));
        if (ci)
            exit(1);
        end
    end

    if (ci)
        exit(any([results.Failed]));
    end
end

%% run_tests:
function [results] = run_tests()
    clear functions;

    import matlab.unittest.TestSuite
    import matlab.unittest.TestRunner;
    import matlab.unittest.plugins.CodeCoveragePlugin;

    runner = TestRunner.withTextOutput;

    % Since the function name of a test described the tests' behavior we don't want to limit
    % the length of a function name
    warning off MATLAB:namelengthmaxexceeded;
    % suite = TestSuite.fromFolder('tests', 'IncludingSubfolders', true);
    suite = TestSuite.fromPackage('tests', 'IncludingSubpackages', true);

    results = runner.run(suite);
    warning on MATLAB:namelengthmaxexceeded;
end