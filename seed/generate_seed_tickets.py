"""Seed data for the SharePoint list TBL_Tickets (fabricated). Import via list 'Import from Excel/CSV' or PnP."""
import argparse
import csv
import random
from datetime import date, timedelta

DEPTS = ["IT", "HR", "Facilities", "Management"]
STATUS = ["New", "In Progress", "On Hold", "Closed"]
PRIORITY = ["Low", "Medium", "High"]
SUBJECTS = ["Laptop won't boot", "Badge access request", "AC not working", "VPN issue", "Payroll question", "Printer jam"]


def build(n, rng, today=None):
    today = today or date.today()
    rows = []
    for i in range(1, n + 1):
        created = today - timedelta(days=rng.randint(0, 20))
        status = rng.choices(STATUS, [30, 35, 10, 25])[0]
        closed = created + timedelta(days=rng.randint(0, 5)) if status == "Closed" else None
        if closed and closed > today:
            closed = today
        rows.append({"Title": f"TKT-{i:04d}", "IndexID": i, "Department": rng.choice(DEPTS), "AssignedTo": f"staff{rng.randint(1, 6)}@example.com",
                     "Subject": rng.choice(SUBJECTS), "Description": "Seed ticket (fabricated).", "Status": status,
                     "Priority": rng.choice(PRIORITY), "Owner": f"user{rng.randint(1, 15)}@example.com",
                     "DateCreated": created.isoformat(), "DateClosed": closed.isoformat() if closed else ""})
    return rows


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="seed/tickets.csv")
    ap.add_argument("--n", type=int, default=40)
    ap.add_argument("--seed", type=int, default=9)
    a = ap.parse_args(argv)
    rows = build(a.n, random.Random(a.seed))
    with open(a.out, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)


if __name__ == "__main__":
    main()
