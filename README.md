# SSH tunnel in Docker

Use case: allow your Docker containers to use SSH tunnels
to get into those hard to reach places like corporate resources,
firewalled APIs etc.

## Usage with Docker Compose

```yaml
services:
    # your reglar services
    
    ssh-tunnel:
        image: sigwinhq/ssh-tunnel:latest
        environment:
            # if the key is password-protected
            SSH_AUTH_SOCK: "/ssh-agent"
            # the host via which we tunnel
            TUNNEL_HOST: "username@ssh.host.you.can.reach.example.com"
            # what do we want to proxy to?
            FORWARD_DSN: "*:443:firewalled-api.example.com:443"
        volumes:
            # your key is now usable by the tunnel
            - $HOME/.ssh:/root/ssh:ro
            # if the key is password-protected
            - $SSH_AUTH_SOCK:/ssh-agent
        # this part is to make the tunnel transparent to others
        networks:
            default:
                aliases:
                    - firewalled-api.example.com
```

After doing this, your other services should now have access
to the firewalled API as if it's available directly,
without even knowing about the proxy.
