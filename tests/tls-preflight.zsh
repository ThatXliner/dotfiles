#!/usr/bin/env zsh
set -eu
source "${0:A:h:h}/scripts/setup"

# Replace only the network boundary. Exercise the real preflight decisions.
curl() {
    if [[ "$*" == *example.com* ]]; then
        return ${CONTROL_RESULT:-0}
    fi
    return ${CURL_RESULT:-60}
}
git() {
    if [[ "$*" == *github.com* ]]; then
        return ${GIT_CONTROL_RESULT:-0}
    fi
    print -u2 -- "${GIT_ERROR:-SSL certificate problem: unable to get local issuer certificate}"
    return ${GIT_RESULT:-128}
}
expect_failure() {
    if (check_tls) >/dev/null 2>&1; then
        print -u2 -- "Preflight accepted $1"
        exit 1
    fi
}
# A failing TLS request is expected here, so disable errexit as setup does.
set +e
(check_tls) || exit 1
CURL_RESULT=0 expect_failure 'trusted compromised curl chain'
CURL_RESULT=28 expect_failure 'curl timeout'
CURL_RESULT=6 expect_failure 'curl DNS failure'
GIT_ERROR='Could not resolve host' expect_failure 'Git DNS failure'
GIT_RESULT=0 expect_failure 'trusted compromised Git chain'
CONTROL_RESULT=60 expect_failure 'broken curl control'
GIT_CONTROL_RESULT=128 expect_failure 'broken Git control'
print 'TLS preflight behavior tests passed'
