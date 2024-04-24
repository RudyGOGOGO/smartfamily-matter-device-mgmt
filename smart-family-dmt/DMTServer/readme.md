In order to make the server run in the local laptop as a server, use the following command
```commandline
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
Then the server will use the IP address of the current WiFi as the host, for example `192.168.12.167`

We can use the following url to get the API interface
`192.168.12.167:8000/docs`