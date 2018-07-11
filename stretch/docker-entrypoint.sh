#!/bin/sh
set -e
CONFDIR=/etc/exim4

# Set smarthost.
DC_EXIMCONFIG_CONFIGTYPE="internet"
if [ "x$RELAY_HOST" != "x" ]; then
    DC_EXIMCONFIG_CONFIGTYPE="satellite"
    DC_SMARTHOST="$RELAY_HOST::${RELAY_PORT:-25}"
    if [ "x$RELAY_USERNAME" != "x" ] && [ "x$RELAY_PASSWORD" != "x" ]; then
        printf '%s\n' "*:$RELAY_USERNAME:$RELAY_PASSWORD" > "$CONFDIR/passwd.client"
    fi
fi

# Write exim configuration.
cat << EOF > "$CONFDIR/update-exim4.conf.conf"
dc_eximconfig_configtype='$DC_EXIMCONFIG_CONFIGTYPE'
dc_other_hostnames=''
dc_local_interfaces=''
dc_readhost=''
dc_relay_domains=''
dc_minimaldns='false'
dc_relay_nets='0.0.0.0/0'
dc_smarthost='${DC_SMARTHOST:-}'
CFILEMODE='644'
dc_use_split_config='false'
dc_hide_mailname='true'
dc_mailname_in_oh='true'
dc_localdelivery='mail_spool'
EOF

# Set primary_hostname.
if [ "x$MAILNAME" != "x" ]; then
    printf '%s\n' "$MAILNAME" > /etc/mailname
    printf '%s\n' "MAIN_HARDCODE_PRIMARY_HOSTNAME=$MAILNAME" >> "$CONFDIR/update-exim4.conf.conf"
fi

# Apply exim configuration.
update-exim4.conf

exec "$@"
