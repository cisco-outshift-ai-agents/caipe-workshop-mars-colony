#!/bin/bash

ETIPATH="/usr/share/etilabs"

CNT=`head -n 1 $ETIPATH/details | tail -1`
LABNAME=`head -n 2 $ETIPATH/details | tail -1`
LABURL=`head -n 3 $ETIPATH/details | tail -1`

#in case there is some additional file with keys, accounts, read the $CNT line. File should be in this same directory
#LINE=`head -n $CNT $ETIPATH/labinit/update/content/init/accounts | tail -1`
#set $LINE
#rm -f $ETIPATH/labinit/update/content/init/accounts

# Enable Mermaid.js support by adding a separate script injection endpoint
cat > /tmp/mermaid-inject.html << 'EOF'
<script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
<script>
// Wait for everything to load first
window.addEventListener('load', function() {
    if (typeof mermaid !== 'undefined') {
        mermaid.initialize({
            startOnLoad: false,
            theme: 'default',
            securityLevel: 'loose'
        });

        // Function to process mermaid blocks
        function processMermaidBlocks() {
            document.querySelectorAll('pre code.language-mermaid').forEach(function(codeElement, index) {
                const preElement = codeElement.parentNode;
                const div = document.createElement('div');
                div.className = 'mermaid';
                div.id = 'mermaid-' + index;
                div.textContent = codeElement.textContent.trim();

                // Replace the pre element with the mermaid div
                preElement.parentNode.replaceChild(div, preElement);
            });

            // Re-initialize mermaid after DOM changes
            if (document.querySelector('.mermaid')) {
                mermaid.init();
            }
        }

        // Process immediately
        processMermaidBlocks();

        // Also watch for dynamic content changes
        const observer = new MutationObserver(function(mutations) {
            let shouldProcess = false;
            mutations.forEach(function(mutation) {
                if (mutation.addedNodes.length > 0) {
                    mutation.addedNodes.forEach(function(node) {
                        if (node.nodeType === 1 && node.querySelector && node.querySelector('code.language-mermaid')) {
                            shouldProcess = true;
                        }
                    });
                }
            });
            if (shouldProcess) {
                setTimeout(processMermaidBlocks, 100);
            }
        });

        observer.observe(document.body, { childList: true, subtree: true });
    }
});
</script>
EOF

# Create a mermaid endpoint that serves the script
if [ -d "/var/www/html" ]; then
    sudo mkdir -p /var/www/html/assets
    sudo cp /tmp/mermaid-inject.html /var/www/html/assets/mermaid.html
fi

# Add mermaid asset serving to nginx config
cat > /tmp/mermaid-location.conf << 'EOF'

# Serve mermaid assets
location /assets/mermaid.html {
    root /var/www/html;
    add_header Content-Type text/html;
    add_header Access-Control-Allow-Origin *;
}
EOF

# Append to existing rag config
cat $ETIPATH/labinit/update/content/init/rag /tmp/mermaid-location.conf > /tmp/combined-rag.conf
sudo cp /tmp/combined-rag.conf $ETIPATH/labinit/update/content/init/rag

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
