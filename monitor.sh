#!/bin/bash
# MAHORAGA Monitoring Helper Script
# Usage: ./monitor.sh [status|logs|enable|disable]

# Configuration
export MAHORAGA_TOKEN="${MAHORAGA_API_TOKEN:-uU4IxjXcLGZyrK2Qvqh6kPgAZ5jRC9tmKuc4mgIZr49v1IKwesEInRISAprZiCub}"
export MAHORAGA_URL="https://mahoraga.pagesofadil.workers.dev"

# Helper functions
api_call() {
  local endpoint=$1
  local method=${2:-GET}
  curl -s -X "$method" "$MAHORAGA_URL/agent/$endpoint" \
    -H "Authorization: Bearer $MAHORAGA_TOKEN"
}

# Commands
case "${1:-status}" in
  status)
    echo "📊 Agent Status:"
    api_call "status" | jq '{
      enabled: .data.enabled,
      crypto_enabled: .data.config.crypto_enabled,
      equity: .data.account.equity,
      positions: (.data.positions | length),
      signals: (.data.signals | length),
      market_open: .data.clock.is_open
    }'
    ;;
    
  logs)
    limit=${2:-10}
    echo "📋 Recent Logs (last $limit):"
    api_call "logs?limit=$limit" | jq -r '.logs[-'$limit':] | .[] | "\(.timestamp) [\(.agent)] \(.action)"'
    ;;
    
  enable)
    echo "🚀 Enabling agent..."
    api_call "enable" "POST" | jq .
    ;;
    
  disable)
    echo "🛑 Disabling agent..."
    api_call "disable" "POST" | jq .
    ;;
    
  signals)
    echo "📡 Active Signals:"
    api_call "signals" | jq '.signals[] | {symbol, source, sentiment, volume}'
    ;;
    
  costs)
    echo "💰 LLM Costs:"
    api_call "costs" | jq .costs
    ;;
    
  watch)
    echo "👀 Watching agent status (Ctrl+C to stop)..."
    while true; do
      clear
      echo "=== MAHORAGA Status @ $(date) ==="
      api_call "status" | jq '{
        enabled: .data.enabled,
        equity: .data.account.equity,
        positions: (.data.positions | length),
        signals: (.data.signals | length),
        market_open: .data.clock.is_open,
        last_analyst_run: .data.lastAnalystRun
      }'
      echo ""
      echo "Recent Activity:"
      api_call "logs?limit=5" | jq -r '.logs[-5:] | .[] | "\(.timestamp) [\(.agent)] \(.action)"'
      sleep 5
    done
    ;;
    
  *)
    echo "Usage: $0 {status|logs|enable|disable|signals|costs|watch}"
    echo ""
    echo "Commands:"
    echo "  status   - Show current agent status"
    echo "  logs     - Show recent activity logs (default: 10)"
    echo "  enable   - Enable the autonomous agent"
    echo "  disable  - Disable the autonomous agent"
    echo "  signals  - Show active trading signals"
    echo "  costs    - Show LLM API costs"
    echo "  watch    - Live monitoring (refreshes every 5s)"
    exit 1
    ;;
esac
