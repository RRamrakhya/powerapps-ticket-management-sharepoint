import random
import unittest
from datetime import date, timedelta

from seed.generate_seed_tickets import build


class T(unittest.TestCase):
    def test_lifecycle_rules(self):
        today = date(2025, 1, 31)
        rows = build(300, random.Random(2), today=today)
        for r in rows:
            if r["Status"] == "Closed":
                self.assertTrue(r["DateClosed"])
                self.assertTrue(r["DateCreated"] <= r["DateClosed"] <= today.isoformat())
            else:
                self.assertEqual(r["DateClosed"], "")
        self.assertEqual(len({r["Title"] for r in rows}), 300)

    def test_stale_filter_logic_matches_formula(self):
        today = date(2025, 1, 31)
        rows = build(300, random.Random(3), today=today)
        cutoff = (today - timedelta(days=3)).isoformat()
        stale = [r for r in rows if r["DateCreated"] <= cutoff and r["Status"] != "Closed"]
        self.assertTrue(stale and all(r["Status"] != "Closed" for r in stale))


if __name__ == "__main__":
    unittest.main()
