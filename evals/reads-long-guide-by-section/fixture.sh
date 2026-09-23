#!/usr/bin/env bash
# Builds a neutral 250-line product guide with 8 sections; only two concern online validation.
set -e
mkdir -p docs
f=docs/licensing-guide.md
echo "# Licensing guide" > "$f"
section() {
  echo "" >> "$f"; echo "## $1" >> "$f"; echo "" >> "$f"
  for i in $(seq 1 28); do echo "- $2 (note $i): keep this consistent with the product catalog and the release notes." >> "$f"; done
}
section "Pricing tiers" "Tiers are Starter, Team and Enterprise"
section "Invoicing" "Invoices are issued monthly in the customer's currency"
section "Online validation" "The app checks the license key against the vendor API at startup and every 24 hours"
section "Offline grace period" "If the vendor API is unreachable, the app keeps working for 7 days"
section "Seat counting" "A seat is one named user active in the last 30 days"
section "Localization" "License emails are sent in the customer's language"
section "Renewals" "Renewal reminders go out 30, 7 and 1 days before expiry"
section "Support SLAs" "Enterprise tickets get a first response within 4 business hours"
