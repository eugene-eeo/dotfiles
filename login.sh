# for some reason gpg isn't starting up automatically
# so git commit fails sometimes
export PATH="/usr/local/bin:$PATH"
gpg-agent --daemon
