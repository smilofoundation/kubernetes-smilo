#!/bin/ash
PRIVATE_CONFIG=$TM_HOME/tm.ipc geth --exec "loadScript(\"$1\")" attach ipc:$SMILO_HOME/dd/geth.ipc
