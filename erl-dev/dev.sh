#!/bin/sh -x

# -d turns off caching.
#yaws -i -d -pa src -c yaws.conf -sname dev

erl -pa $PWD/ebin $PWD/*/ebin \
    -sname erl-dev \
    -boot start_sasl -config dev \
    -eval 'code:load_abs("ebin/user_default").'

#    -eval 'mnesia:start([{dir,"mnesia"}]).'
#    -mnesia dir \"mnesia\" 

#
# these below from
# http://stackoverflow.com/questions/1182025/what-do-the-erlang-emulator-info-statements-mean
#

#
# for kernel poll '+K true'
#
#[async-threads:0]
# Size of async thread pool available for loaded drivers to use.
# This allows blocking syscalls to be performed in a separate kernel thread from the beam vm.
# Use command switch +A N to adjust the size of the pool.
#
