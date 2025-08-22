#!/bin/bash

ETIPATH="/usr/share/etilabs"

CNT=`head -n 1 $ETIPATH/details | tail -1`
LABNAME=`head -n 2 $ETIPATH/details | tail -1`
LABURL=`head -n 3 $ETIPATH/details | tail -1`

#in case there is some additional file with keys, accounts, read the $CNT line. File should be in this same directory
#LINE=`head -n $CNT $ETIPATH/labinit/update/content/init/accounts | tail -1`
#set $LINE
#rm -f $ETIPATH/labinit/update/content/init/accounts

# Enable Mermaid.js support by injecting script into markdown content
cat > /tmp/mermaid-inject.js << 'EOF'
// Inject Mermaid.js into any served HTML content
document.addEventListener('DOMContentLoaded', function() {
    if (!document.querySelector('script[src*="mermaid"]')) {
        var script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js';
        script.onload = function() {
            mermaid.initialize({ startOnLoad: true, theme: 'default' });
            // Convert markdown mermaid blocks to mermaid divs
            document.querySelectorAll('pre code.language-mermaid').forEach(function(element) {
                var div = document.createElement('div');
                div.className = 'mermaid';
                div.textContent = element.textContent;
                element.parentNode.parentNode.replaceChild(div, element.parentNode);
            });
        };
        document.head.appendChild(script);
    }
});
EOF

# Copy mermaid script to web assets if directory exists
if [ -d "/var/www/html" ]; then
    sudo cp /tmp/mermaid-inject.js /var/www/html/
fi

# Install Docker and Docker Compose for Mars Colony workshop
echo "Installing Docker for Mars Colony workshop..."

# Add Docker repo
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Compose V2 plugin
sudo apt-get install -y docker-compose-plugin
docker compose version

echo "Docker installation completed!"

# additional nginx config
sudo cp -f $ETIPATH/labinit/update/content/init/rag /etc/nginx/paths
sudo nginx -s reload
