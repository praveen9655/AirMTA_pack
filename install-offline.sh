#!/bin/bash
# ===============================================
# Offline Package Installation for airMTA
# ===============================================

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=========================================================${NC}"
echo -e "${BLUE}  airMTA Offline Package Installation${NC}"
echo -e "${BLUE}=========================================================${NC}"
echo ""

if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

cd "$(dirname "$0")/debs"

echo -e "${BLUE}Installing packages...${NC}"
dpkg -i *.deb 2>/dev/null || true

echo ""
echo -e "${BLUE}Fixing dependencies...${NC}"
apt-get install -f -y

echo ""
echo -e "${GREEN}=========================================================${NC}"
echo -e "${GREEN}  Package installation complete!${NC}"
echo -e "${GREEN}=========================================================${NC}"
echo ""
echo "Installed versions:"
dpkg -l | grep -E "postfix|dovecot|opendkim|fail2ban" | grep ^ii
echo ""
