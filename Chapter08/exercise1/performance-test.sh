#!/bin/bash
ENDPOINT=$1
N=100

START=$(date +%s)
for i in $(seq ${N}); do
	curl http://${ENDPOINT}/hello
done
END=$(date +%s)

RUNTIME=$((END-START))
AVG=$((RUNTIME/N))

test ${AVG} -lt 1
