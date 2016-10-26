Daemon
FlexGet can be run in daemon mode, which means it will always run in the background, periodically running tasks on a schedule, or running the tasks initiated by another instance of FlexGet.

Usage
To launch the FlexGet daemon, use the start command: 
Note: Using the optional -d switch will send the FlexGet daemon to the background.

flexget daemon start [-d]


To stop a currently running daemon you can use stop:

flexget daemon stop


To check the status of the flexget daemon you can use status:

flexget daemon status


To have the daemon reload the config file from disk you can use the reload command:

flexget daemon reload
