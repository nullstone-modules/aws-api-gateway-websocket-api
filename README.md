This module creates an API Gateway with websockets routes configured.
The $request.body.action passed as part of the request is used to determine the route to be taken.

This modules sets up routes for the following paths/actions:

| Body Action | Path |
|-----------|-----------|
| $connect    | `${subdomain_url}/${path}/websocket/connect` |
| $default    | `${subdomain_url}/${path}/websocket/default` |
| $disconnect | `${subdomain_url}/${path}/websocket/disconnect` |
| chat        | `${subdomain_url}/${path}/websocket/chat` |
| message     | `${subdomain_url}/${path}/websocket/message` |
