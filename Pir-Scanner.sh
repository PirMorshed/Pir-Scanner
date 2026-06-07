#!/usr/bin/env bash

# =========================================================
# TITLE:   ULTIMATE BRANDED INFRA SCANNER (PIR MORSHED)
# VERSION: 8.0 (MAX-RANGE & BRANDED COLORS)
# =========================================================

# Standard Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# --- BRAND COLORS (Extended 256-Color Palette) ---
CF_ORANGE='\033[38;5;208m'
FASTLY_RED='\033[38;5;196m'
AWS_GOLD='\033[38;5;214m'
G_BLUE='\033[38;5;33m'
AZURE_BLUE='\033[38;5;45m'
IRAN_GREEN='\033[38;5;82m'

RESULT_FILE=$(mktemp)

# =========================================================
#        GLOBAL INFRASTRUCTURE - THE COMPLETE DATABASE
# =========================================================

CF_RANGES=("173.245.48.0/20" "103.21.244.0/22" "103.22.200.0/22" "103.31.4.0/22" "141.101.64.0/18" "108.162.192.0/18" "190.93.240.0/20" "188.114.96.0/20" "197.234.240.0/22" "198.41.128.0/17" "162.158.0.0/15" "104.16.0.0/13" "172.64.0.0/13" "131.0.72.0/22")

FASTLY_RANGES=("23.235.32.0/20" "43.249.72.0/22" "103.244.50.0/24" "103.245.222.0/23" "103.254.164.0/22" "104.156.80.0/20" "140.248.64.0/18" "146.75.0.0/16" "151.101.0.0/16" "157.185.0.0/16" "167.99.0.0/16" "172.111.64.0/18" "185.31.16.0/22" "199.27.72.0/21" "199.232.0.0/16" "202.21.128.0/24" "203.57.145.0/24")

AMAZON_RANGES=("13.32.0.0/15" "13.224.0.0/14" "18.154.0.0/15" "52.46.0.0/18" "52.84.0.0/15" "54.182.0.0/16" "54.192.0.0/16" "54.230.0.0/16" "54.239.128.0/18" "54.240.128.0/18" "64.252.64.0/18" "204.246.164.0/22" "15.158.0.0/16" "3.160.0.0/14" "99.84.0.0/16" "99.86.0.0/16" "13.249.0.0/16")

GOOGLE_RANGES=("34.80.0.0/12" "35.184.0.0/13" "35.192.0.0/14" "35.200.0.0/13" "35.208.0.0/12" "104.154.0.0/15" "104.196.0.0/14" "107.167.160.0/19" "107.178.192.0/18" "108.170.192.0/18" "108.177.0.0/17" "130.211.0.0/16" "142.250.0.0/15" "173.194.0.0/16")

AZURE_RANGES=("13.64.0.0/11" "20.33.0.0/16" "20.150.0.0/15" "40.64.0.0/10" "52.132.0.0/14" "52.136.0.0/13" "52.152.0.0/13" "104.40.0.0/13" "104.208.0.0/13" "157.54.0.0/15" "191.232.0.0/14")

# --- IRAN FULL SPECTRUM ---
IRAN_MCI=("94.182.128.0/18" "80.191.0.0/16" "194.225.0.0/16" "185.208.174.0/24" "192.15.0.0/16" "84.47.128.0/17")
IRAN_MTN=("109.108.0.0/16" "92.42.0.0/16" "185.143.232.0/22" "5.200.128.0/24" "37.156.0.0/16" "176.12.32.0/19")
IRAN_ARVAN=("185.143.232.0/22" "188.121.64.0/18" "185.239.104.0/22" "94.182.153.0/24" "185.176.4.0/22" "5.200.128.0/24")
IRAN_ASIATECH=("185.120.220.0/22" "185.129.168.0/22" "185.10.74.0/23" "185.208.172.0/22" "185.117.144.0/22")
IRAN_AFRANET=("188.121.96.0/19" "185.12.72.0/22" "194.225.0.0/16" "185.129.172.0/22")
IRAN_SHATEL_PARS=("185.8.172.0/22" "185.211.56.0/22" "91.98.0.0/16" "91.99.0.0/16" "82.115.0.0/17")
IRAN_RESPINA_MOBIN=("94.232.160.0/20" "103.214.124.0/22" "46.209.0.0/16" "185.121.0.0/22" "178.252.128.0/18")
IRAN_TIC_OTHERS=("2.184.0.0/13" "5.144.0.0/13" "78.38.0.0/15" "185.105.239.0/24" "5.160.0.0/13" "158.58.184.0/21")
IRAN_ALL=("${IRAN_MCI[@]}" "${IRAN_MTN[@]}" "${IRAN_ARVAN[@]}" "${IRAN_ASIATECH[@]}" "${IRAN_AFRANET[@]}" "${IRAN_SHATEL_PARS[@]}" "${IRAN_RESPINA_MOBIN[@]}" "${IRAN_TIC_OTHERS[@]}")

# --- GLOBAL DNS ---
DNS_LIST=("1.1.1.1" "8.8.8.8" "9.9.9.9" "1.0.0.1" "8.8.4.4" "178.22.122.100" "185.51.200.2" "10.202.10.10" "4.2.2.4" "76.76.2.0")

banner() {
  clear
  echo -e "${CYAN}╔══════════════════════════════════════════════════[ CORE v2.1 ]═════╗${NC}"
  echo -e "${CYAN}║                                                                    ║${NC}"
  echo -e "${CYAN}║${NC}       ${BOLD}${CYAN}█▀▀█ ▀█▀ █▀▀█     █▀▀▀ █▀▀▀ █▀▀█ █▄  █ █▄  █ █▀▀▀ █▀▀█${NC}       ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}       ${BOLD}${CYAN}█▄▄█  █  █▄▄▀     ▀▀▀█ █    █▄▄█ █ █ █ █ █ █ █ ▀  █▄▄▀${NC}       ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}       ${BOLD}${CYAN}█    ▄█▄ █ ▀▄     ▀▀▀▀ ▀▀▀▀ ▀  ▀ ▀  ▀▀ ▀  ▀▀ ▀▀▀▀ █ ▀▄${NC}       ${CYAN}║${NC}"
  echo -e "${CYAN}║                                                                    ║${NC}"
  echo -e "${CYAN}╠════════════════════════════════════════════════════════════════════╣${NC}"
  echo -e "${CYAN}║${NC}                      ${BOLD}${PURPLE}ULTIMATE QUALITY SCANNER${NC}                      ${CYAN}║${NC}"
  echo -e "${CYAN}╚════════════════════════════════════════════════════════════════════╝${NC}"
}

echo -e "\n"

random_ip_from_cidr() {
    local cidr=$1; local ip=$(echo $cidr | cut -d/ -f1); local mask=$(echo $cidr | cut -d/ -f2)
    IFS=. read -r i1 i2 i3 i4 <<< "$ip"
    local ip_num=$(( (i1 << 24) + (i2 << 16) + (i3 << 8) + i4 ))
    local hosts=$(( 2**(32 - mask) )); local random_offset=$(( RANDOM % hosts ))
    local random_ip_num=$(( ip_num + random_offset ))
    echo "$(( (random_ip_num >> 24) & 255 )).$(( (random_ip_num >> 16) & 255 )).$(( (random_ip_num >> 8) & 255 )).$(( random_ip_num & 255 ))"
}

ping_check() {
    local target=$1
    if out=$(ping -c 2 -W 1 "$target" 2>/dev/null); then
        local lat=$(echo "$out" | tail -n 1 | awk -F'/' '{print $5}')
        echo "$target|$lat" >> "$RESULT_FILE"
        echo -e "${GREEN}[✔]${NC} ${BOLD}$target${NC} | Latency: ${GREEN}${lat}ms${NC}"
    else
        echo -e "${RED}[✘]${NC} ${BOLD}$target${NC} | ${RED}TIMEOUT${NC}"
    fi
}

start_scan() {
    local name=$1; local color=$2; shift 2; local ranges=("$@")
    > "$RESULT_FILE"
    banner
    echo -e "${PURPLE}Selected Infrastructure:${NC} ${BOLD}${color}$name${NC}"
    echo -e "${PURPLE}Pool Size:${NC} ${GREEN}${#ranges[@]} Subnets Loaded${NC}"
    echo -e "${CYAN}──────────────────────────────────────────────────────────────────────${NC}"
    read -p "Number of IPs to scan? [Default 20]: " count
    [[ ! $count =~ ^[0-9]+$ ]] && count=20
    
    local max_parallel=64; local running=0
    for ((i=0; i<count; i++)); do
        local random_range="${ranges[$((RANDOM % ${#ranges[@]}))]}"
        local target_ip=$(random_ip_from_cidr "$random_range")
        ping_check "$target_ip" &
        ((running++)); if (( running >= max_parallel )); then wait -n; ((running--)) ; fi
    done
    wait

    echo -e "\n${CYAN}──────────────────────────────────────────────────────────────────────${NC}"
    echo -e "                   ${BOLD}${YELLOW}🏆 TOP RANKED NODES (BY QUALITY)${NC}"
    echo -e "${CYAN}──────────────────────────────────────────────────────────────────────${NC}"
    sort -t'|' -k2 -n "$RESULT_FILE" | head -n 25 | while IFS='|' read -r ip lat; do
        printf "  ${BOLD}${color}%-16s${NC} | ${CYAN}%-8s ms${NC}\n" "$ip" "$lat"
    done
    echo -e "${CYAN}──────────────────────────────────────────────────────────────────────${NC}"
    read -p "Press ENTER to return..." _
}

iran_menu() {
    while true; do
        banner
        echo -e " ${BOLD}${IRAN_GREEN}IRANIAN DATA CENTERS SELECTION:${NC}"
        echo -e "  1) Hamrah Aval (MCI) Enterprise"
        echo -e "  2) Irancell (MTN) DC Infrastructure"
        echo -e "  3) ArvanCloud (Anycast Edge)"
        echo -e "  4) Asiatech (Milad/DC)"
        echo -e "  5) Afranet Core DC"
        echo -e "  6) Shatel & Pars Online"
        echo -e "  7) Respina & Mobinnet Business"
        echo -e "  8) TIC & Other Cloud Providers"
        echo -e "  ${BOLD}${CYAN}9) SCAN ALL IRAN INFRASTRUCTURE${NC}"
        echo -e "  ${BOLD}${RED}0) Back${NC}"
        echo -ne "\nChoice: "
        read subopt
        case "$subopt" in
            1) start_scan "MCI-Infrastructure" "$IRAN_GREEN" "${IRAN_MCI[@]}" ;;
            2) start_scan "MTN-Infrastructure" "$IRAN_GREEN" "${IRAN_MTN[@]}" ;;
            3) start_scan "Arvan-Anycast" "$IRAN_GREEN" "${IRAN_ARVAN[@]}" ;;
            4) start_scan "Asiatech-DC" "$IRAN_GREEN" "${IRAN_ASIATECH[@]}" ;;
            5) start_scan "Afranet-DC" "$IRAN_GREEN" "${IRAN_AFRANET[@]}" ;;
            6) start_scan "Shatel-Pars" "$IRAN_GREEN" "${IRAN_SHATEL_PARS[@]}" ;;
            7) start_scan "Respina-Mobinnet" "$IRAN_GREEN" "${IRAN_RESPINA_MOBIN[@]}" ;;
            8) start_scan "TIC-Infrastructure" "$IRAN_GREEN" "${IRAN_TIC_OTHERS[@]}" ;;
            9) start_scan "Iran-All-DC" "$IRAN_GREEN" "${IRAN_ALL[@]}" ;;
            0) break ;;
        esac
    done
}

while true; do
    banner
    echo -e " ${BOLD}${CF_ORANGE}1) Cloudflare Edge Full Network${NC}"
    echo -e " ${BOLD}${FASTLY_RED}2) Fastly Global CDN Edge${NC}"
    echo -e " ${BOLD}${AWS_GOLD}3) Amazon CloudFront / AWS Infrastructure${NC}"
    echo -e " ${BOLD}${G_BLUE}4) Google Cloud Platform (GCP)${NC}"
    echo -e " ${BOLD}${AZURE_BLUE}5) Microsoft Azure FrontDoor${NC}"
    echo -e " ${BOLD}${IRAN_GREEN}6) IRAN DATA CENTERS (Advanced Menu)${NC}"
    echo -e " ${BOLD}${BLUE}7) Global DNS Benchmarking${NC}"
    echo -e " ${BOLD}${RED}0) Exit${NC}"
    echo -ne "\nSelect Provider: "
    read opt
    case "$opt" in
        1) start_scan "Cloudflare" "$CF_ORANGE" "${CF_RANGES[@]}" ;;
        2) start_scan "Fastly" "$FASTLY_RED" "${FASTLY_RANGES[@]}" ;;
        3) start_scan "Amazon-AWS" "$AWS_GOLD" "${AMAZON_RANGES[@]}" ;;
        4) start_scan "Google-Cloud" "$G_BLUE" "${GOOGLE_RANGES[@]}" ;;
        5) start_scan "Microsoft-Azure" "$AZURE_BLUE" "${AZURE_RANGES[@]}" ;;
        6) iran_menu ;;
        7) banner; for dns in "${DNS_LIST[@]}"; do ping_check "$dns" & done; wait; 
           echo -e "\n${BLUE}Sorted DNS Ranking:${NC}"; sort -t'|' -k2 -n "$RESULT_FILE" | while IFS='|' read -r ip lat; do printf "  %-16s | %s ms\n" "$ip" "$lat"; done; read -p "Press ENTER..." _ ;;
        0) rm -f "$RESULT_FILE"; exit 0 ;;
    esac
done