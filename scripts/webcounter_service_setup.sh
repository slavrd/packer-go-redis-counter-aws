#!/usr/bin/env bash
# Installs the webcounter bin as a systemd service

sudo cp "/tmp/webcounter.service" "/etc/systemd/system/webcounter.service" || exit 1

sudo systemctl enable webcounter.service || exit 1

sudo systemctl start webcounter.service || exit 1
