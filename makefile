.PHONY: clean all start stop

WORKERS=worker1 worker2 worker3

all: master ${WORKERS} repos

start: master ${WORKERS} repos
	./mst start
	./w1 start
	./w2 start
	./w3 start

stop:
	./mst stop
	./w1 stop
	./w2 stop
	./w3 stop

repos:
	sh mk-repos.sh

master:
	sh mk-master.sh

worker1:
	sh mk-worker.sh 1

worker2:
	sh mk-worker.sh 2

worker3:
	sh mk-worker.sh 3

clean:
	test -e mst && ./mst stop || true
	test -e w1 && ./w1 stop || true
	test -e w2 && ./w2 stop || true
	test -e w3 && ./w3 stop || true
	rm -Rf master mst worker* w? repos
