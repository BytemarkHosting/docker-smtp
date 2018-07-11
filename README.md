# https://github.com/BytemarkHosting/docker-smtp

## Maintained by: [Bytemark Hosting](https://www.bytemark.co.uk)

This is the Git repo of the bytemark/smtp image.

This image allows linked containers to send outgoing email. You can configure
it to send email directly to the recipient, or to act as a smart host and relay
mail to an intermediate server (eg, GMail, SendGrid).

## Usage

### Basic SMTP server

In this example, linked containers can connect to hostname `mail` and port `25`
to send outgoing email. The SMTP container sends email out directly.

```
docker run --restart always --name mail -d bytemark/smtp
```

Via Docker Compose:

```
  mail:
    image: bytemark/smtp
    restart: always
```

Optionally, set `MAILNAME` environment variable. (By default, Exim will use the
hostname of the container.)

### SMTP smart host

In this example, linked containers can connect to hostname `mail` and port `25`
to send outgoing email. The SMTP container acts as a smart host and relays mail
to an intermediate server server (eg, GMail, SendGrid).

```
docker run --restart always --name mail -d bytemark/smtp \
    -e RELAY_HOST=smtp.example.com \
    -e RELAY_PORT=587 \
    -e RELAY_USERNAME=alice@example.com \
    -e RELAY_PASSWORD=secretpassword
```

Via Docker Compose:

```
  mail:
    image: bytemark/smtp
    restart: always
    environment:
      RELAY_HOST: smtp.example.com
      RELAY_PORT: 587
      RELAY_USERNAME: alice@example.com
      RELAY_PASSWORD: secretpassword
```

Optionally, set `MAILNAME` environment variable. (By default, Exim will use the
hostname of the container.)
