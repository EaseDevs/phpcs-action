#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

if [ -n "${INPUT_INSTALLED_PATHS}" ]; then
    /phpcs --config-set installed_paths "${INPUT_INSTALLED_PATHS}"
fi

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    /phpcs ${github.workspace} -n --report=checkstyle -d memory_limit=512M
else
    echo "Check for warnings enabled"

    /phpcs ${github.workspace} --report=checkstyle -d memory_limit=512M
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit 0
