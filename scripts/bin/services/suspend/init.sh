sudo cp ~/bin/services/suspend/suspend.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable suspend
