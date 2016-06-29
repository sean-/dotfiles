setenv TEST_ENTER_TCSH "Set from ${PWD}"
printf 'Ran .enter.tcsh, set "TEST_ENTER_TCSH" environment variable\n'
env | grep TEST_ENTER_TCSH

# Can be very useful for activating python virtualenv's:
#
# source bin/activate.tcsh

# or remembering to set directory specific build settings like:
#
# setenv CPPFLAGS -I/opt/local/include
# setenv LDFLAGS -L/opt/local/lib
# setenv CFLAGS -g

# or per-project PostgreSQL environment variables:
#
# http://www.postgresql.org/docs/current/static/libpq-envars.html
#
# setenv PGUSER postgres
