# MyMoneyManagerExReports — CLAUDE.md

## Project Overview

Custom reports for [Money Manager Ex (MMEX)](https://www.moneymanagerex.org/), a free open-source personal finance app backed by an SQLite database. Each report = SQL query + HTML template + client-side JS.

## Report Anatomy

Every report lives in its own folder and follows this structure:

| File | Purpose |
|------|---------|
| `ReportName.sql` | SQLite query against the MMEX database |
| `ReportName.template` | HTML template with `<TMPL_*>` injection points |
| `ReportName.js` | Client-side JS (formatting, charts, calculations) |
| `ReportName.grm` | ZIP bundle (sql + template + description) — the file MMEX imports |

Some newer reports skip the `.grm`/`.template` split and use a single `index.html` + `script.js`.

## Template Syntax

MMEX uses a Perl Template Toolkit–style processor:

```html
<TMPL_VAR REPORTNAME>           <!-- report name string -->
<TMPL_LOOP NAME=CONTENTS>       <!-- iterates SQL result rows -->
  '<TMPL_VAR Moment>'           <!-- field values from the query -->
</TMPL_LOOP>
<TMPL_LOOP ERRORS>
  <TMPL_VAR ERROR>              <!-- SQL/runtime errors -->
</TMPL_LOOP>
```

SQL column aliases become template variable names. Always alias every column you want to expose in the template.

## MMEX Database Schema (key tables)

```sql
CHECKINGACCOUNT_V1   -- actual transactions (TRANSID, TRANSDATE, TRANSAMOUNT, TOTRANSAMOUNT, TRANSCODE, ACCOUNTID, TOACCOUNTID, PAYEEID, CATEGID, SUBCATEGID, STATUS, NOTES)
BILLSDEPOSITS_V1     -- recurring/scheduled transactions (same shape + NEXTOCCURRENCEDATE, REPEATS)
ACCOUNTLIST_V1       -- accounts (ACCOUNTID, ACCOUNTNAME, INITIALBAL)
PAYEE_V1             -- payees (PAYEEID, PAYEENAME)
CATEGORY_V1          -- categories (CATEGID, CATEGNAME)
SUBCATEGORY_V1       -- subcategories (SUBCATEGID, SUBCATEGNAME, CATEGID)
```

`TRANSCODE` values: `Deposit`, `Withdrawal`, `Transfer`  
`STATUS`: `R` (reconciled), `V` (void), empty (uncleared)

## Recurrence Codes in BILLSDEPOSITS_V1

| REPEATS value | Meaning |
|---------------|---------|
| 0 | Once |
| 1 | Weekly |
| 2 | Bi-weekly |
| 3 | Monthly |
| 4 | Bi-monthly |
| 11 | Every 3 months |
| 12 | Every 6 months |
| 13 | Annual |
| 1xx / 2xx / 3xx | Auto-entry variants (e.g., 103 = auto-insert monthly) |

## Common JS Patterns

**Currency formatting (Euro)**
```javascript
function currency(n) {
    n = parseFloat(n);
    n = isNaN(n) ? 0 : n.toFixed(2);
    var out = n.toString().replace(".", "|");
    out = out.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    return out.replace("|", ",");
}
// Output: "1.234,56"
```

**Running total** — always computed client-side in JS after template injection.

**Date filtering** — filter by: `all`, `last-year`, `this-year`, `this-quarter`, `last-month`, `this-month`.

## External Dependencies (loaded from CDN)

| Library | Version | Used by |
|---------|---------|---------|
| amCharts 4 | `amcharts.com/lib/4/` | IncomesVsExpensesPercentage (3D Pie) |
| amCharts 5 | `cdn.amcharts.com/lib/5/` | PasiveIncomes, IngresosPasivos |
| underscore.js | CDN or bundled | IncomesVsExpensesPercentage |
| sorttable.js | local (provided by MMEX) | PasiveIncomes, IngresosPasivos |
| master.css | local (provided by MMEX) | All reports |

MMEX injects `master.css` and `sorttable.js` at runtime — they are not in this repo.

## Creating a New Report

1. Create a new folder: `MyNewReport/`
2. Write the SQL query — alias every output column with the exact name the template will reference.
3. Create the HTML template (`.template`) using `<TMPL_LOOP NAME=CONTENTS>` to inject data.
4. Add JS logic directly in the template's `<script>` block (or in a separate `.js` file).
5. Bundle into `.grm`: ZIP the folder contents and rename to `.grm`, or test the template directly in MMEX.

## Naming Conventions

- Folder and file names use PascalCase matching the report name.
- SQL column aliases use PascalCase: `Moment`, `Type`, `Category`, `Amount`, `Ammount` (note legacy typo).
- Spanish UI labels are common (reports are bilingual ES/EN).

## Known Quirks

- Several SQL queries hard-code `ACCOUNTID = 1` — parameterize when generalizing.
- `Ammount` (double-m) is a recurring typo in older reports — match it exactly in templates.
- `TOTRANSAMOUNT` is used for transfers; `TRANSAMOUNT` for regular transactions.
- Recurrence handling for scheduled transactions is done manually in SQL with UNION queries per frequency type — there is no helper.
- amCharts 4 and 5 have incompatible APIs; don't mix them in the same report.
