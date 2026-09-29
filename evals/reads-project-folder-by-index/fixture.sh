#!/usr/bin/env bash
# Builds a neutral project: CLAUDE.md plus five Brain/ docs of ~120 lines each.
# Only two sections (in the migration plan) concern today's task.
set -e
mkdir -p Brain
cat > CLAUDE.md <<'MD'
# Reports app

Internal reporting app of Acme Ltd. The team owns the app and its database.
Project notes live in Brain/. The migration plan is Brain/04_MIGRATION_PLAN.md.
MD
doc() { echo "# $1" > "Brain/$2"; }
section() {
  f="Brain/$1"
  echo "" >> "$f"; echo "## $2" >> "$f"; echo "" >> "$f"
  for i in $(seq 1 28); do echo "- $3 (note $i): keep this in sync with the team wiki." >> "$f"; done
}
doc "Board" 00_BOARD.md
section 00_BOARD.md "Status" "Dashboards render in under two seconds"
section 00_BOARD.md "Owners" "The analytics squad owns the chart widgets"
section 00_BOARD.md "Office" "Office plants are watered on Fridays"
section 00_BOARD.md "Hiring" "Two frontend interviews are scheduled this month"
doc "Sessions" 01_SESSIONS.md
section 01_SESSIONS.md "Week 1" "Sprint retro notes mention flaky chart tests"
section 01_SESSIONS.md "Week 2" "The CSV export now handles UTF-8 headers"
section 01_SESSIONS.md "Week 3" "The team lunch moved to Thursday"
section 01_SESSIONS.md "Week 4" "Color palette review for the dark theme"
doc "Pending" 02_PENDING.md
section 02_PENDING.md "Frontend" "Add a date picker to the sales report"
section 02_PENDING.md "Docs" "Record a walkthrough video for new analysts"
section 02_PENDING.md "Design" "Replace the pie charts with bar charts"
section 02_PENDING.md "Misc" "Order new stickers for the conference booth"
doc "Decisions" 03_DECISIONS.md
section 03_DECISIONS.md "Charts" "We chose the open-source charting library in March"
section 03_DECISIONS.md "Auth" "Single sign-on through the company identity provider"
section 03_DECISIONS.md "Style" "Headings use sentence case in every report"
section 03_DECISIONS.md "Meetings" "Standup is fifteen minutes at 9:30"
doc "Migration plan: reports database to the new cloud host" 04_MIGRATION_PLAN.md
section 04_MIGRATION_PLAN.md "Background" "The old VM was bought in 2019 for the first pilot"
section 04_MIGRATION_PLAN.md "Step 1 - Snapshot" "Take a pg_dump of the reports database at 22:00 with the app in read-only mode"
section 04_MIGRATION_PLAN.md "Rollback" "If the restore check fails, point the app back to the old VM connection string"
section 04_MIGRATION_PLAN.md "Team offsite" "The offsite venue has parking for twelve cars"
