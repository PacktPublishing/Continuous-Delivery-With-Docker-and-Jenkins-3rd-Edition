#!/bin/bash

### BEGIN INIT INFO
# Provides:          hazelcast
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Hazelcast server
### END INIT INFO

java -cp /var/hazelcast/hazelcast.jar com.hazelcast.core.server.StartServer &