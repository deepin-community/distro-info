# Copyright (C) 2012, Benjamin Drung <bdrung@debian.org>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

runCommand() {
    local param="$1"
    local exp_stdout="$2"
    local exp_stderr="$3"
    local exp_retval=$4
    local stdoutF="${SHUNIT_TMPDIR}/stdout"
    local stderrF="${SHUNIT_TMPDIR}/stderr"
    eval "${COMMAND} $param" > ${stdoutF} 2> ${stderrF}
    retval=$?
    assertEquals "standard output of ${COMMAND} $param\n" "$exp_stdout" "$(cat ${stdoutF})"
    assertEquals "error output of ${COMMAND} $param\n" "$exp_stderr" "$(cat ${stderrF})"
    assertEquals "return value of ${COMMAND} $param\n" $exp_retval $retval
}

hasWarning() {
    local param="$1"
    local exp_stderr="$2"
    local stderrF="${SHUNIT_TMPDIR}/stderr"
    eval "${COMMAND} $param" > /dev/null 2> ${stderrF}
    assertEquals "error output of ${COMMAND} $param\n" "$exp_stderr" "$(cat ${stderrF})"
}

success() {
    runCommand "$1" "$2" "" 0
}

failure() {
    runCommand "$1" "" "$2" 1
}
