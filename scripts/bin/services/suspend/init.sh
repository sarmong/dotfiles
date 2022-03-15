sudo ln -s ~/bin/services/suspend/suspend.service /etc/systemd/system
sudo ln -s ~/bin/services/suspend/suspend.sh /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable suspend
