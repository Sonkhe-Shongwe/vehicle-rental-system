"""Dependency-free repository fixture hygiene checks. Run: python3 tests/test_repo_hygiene.py"""
from pathlib import Path

root = Path(__file__).resolve().parents[1]
assert not (root / "vehicles.txt").exists(), "live fleet file must not be distributed"
assert not (root / "rentals.txt").exists(), "live customer file must not be distributed"
assert (root / ".gitignore").exists()
assert (root / "demo" / "vehicles.txt").exists()
assert (root / "demo" / "rentals.txt").exists()

vehicles = {}
for raw in (root / "demo" / "vehicles.txt").read_text().splitlines():
    cols = raw.split("|")
    assert len(cols) == 7 and cols[0] in ("Car", "Motorcycle")
    assert cols[1] not in vehicles
    assert cols[5] in ("0", "1")
    vehicles[cols[1]] = cols

active = set()
for raw in (root / "demo" / "rentals.txt").read_text().splitlines():
    cols = raw.split("|")
    assert len(cols) == 13 and cols[0] == "Rental"
    assert cols[2].startswith("Demo Customer"), "customer must be fictional"
    assert cols[3] == "0000000000", "phone must be a placeholder"
    assert cols[11] in ("0", "1") and cols[12] in ("0", "1")
    if cols[11] == "0":
        assert cols[4] in vehicles and cols[4] not in active
        active.add(cols[4])

for vid, record in vehicles.items():
    assert (record[5] == "1") == (vid in active), "demo occupancy mismatch"

assert sorted(p.name for p in (root / "screenshots").glob("*.png")) == [
    "add-car.png", "add-motorcycle.png", "dashboard-redacted.png"
]
print("PASS: no live data files, synthetic fixtures, record structure and occupancy")
