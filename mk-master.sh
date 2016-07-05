#!/bin/sh

ENV=master
ROOT="$ENV/master"

virtualenv "$ENV"
"$ENV/bin/pip" install -r requirements-master.txt

cat <<END >mst
#!/bin/sh
export LC_CTYPE=C
"$ENV/bin/buildbot" \$* "$ROOT"
END

chmod +x mst

./mst create-master
cp master.tmpl/* "$ROOT"
