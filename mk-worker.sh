#!/bin/sh

ID="$1"

ENV="worker$ID"
ROOT="$ENV/worker"

virtualenv "$ENV"
"$ENV/bin/pip" install -r requirements-worker.txt

cat <<END >"w$ID"
#!/bin/sh
export LC_CTYPE=C
command="\$1"
shift
source "$ENV/bin/activate"
buildbot-worker "\$command" $ROOT \$*
END

chmod +x "w$ID"

"./w$ID" create-worker localhost "worker$ID" "pass$ID"
