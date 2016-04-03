test -n "$srcdir" || srcdir=`dirname "$0"`
test -n "$srcdir" || srcdir=.

test -d "$srcdir/autostuff" || mkdir "$srcdir/autostuff"
autoreconf --force --install --verbose "$srcdir"
