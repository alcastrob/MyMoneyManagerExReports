# MyMoneyManagerExReports

A collection of the reports I created in order to expand this amazing accountability tool.

[Money Manager Ex](https://www.moneymanagerex.org/) is a free, open-source, cross-platform, easy-to-use personal finance software. It primarily helps organize one's finances and keeps track of where, when and how the money goes. It is also a great tool to get a bird's eye view of your financial worth.

Each report is self-contained in its own folder and can be imported into MMEX as a `.grm` file.

---

## Reports

### MonthExpensesEvolution
**Folder:** `MonthExpensesEvolution/`  
**Purpose:** All expenses and recurring withdrawals for the current month, showing actual transactions + scheduled ones not yet posted. Gives a cash-flow snapshot and shows what's still ahead this month.  
**Chart:** None (table only)  
**Date scope:** Current month

---

### NextMonthExpenseForecast
**Folder:** `NextMonthExpenseForecast/`  
**Purpose:** Projects expenses for next month. Useful in the last days of the current month to plan ahead. Handles monthly, bi-monthly, and weekly recurrence patterns.  
**Chart:** None (table only)  
**Date scope:** Next calendar month

---

### In2MonthsExpenseForecast
**Folder:** `In2MonthsExpenseForecast/`  
**Purpose:** Same as NextMonthExpenseForecast but for two months ahead.  
**Chart:** None (table only)  
**Date scope:** Two months from now

---

### IncomesVsExpensesPercentage
**Folder:** `IncomesVsExpensesPercentage/`  
**Purpose:** Compares expenses by category against total income for the last three months. Shows each category as a percentage of total income so you can see where money goes relative to what comes in. Supports split transactions.  
**Chart:** amCharts 4 — 3D Pie chart sorted by amount  
**Date scope:** Last 3 months  
**Notes:** Uses `underscore.js` for data sorting. Handles the case where total expenses exceed total income.

---

### BalanceEvolutionForSpecificAccount
**Folder:** `BalanceEvolutionForSpecificAccount/`  
**Purpose:** Tracks the daily balance evolution of a specific account during the current month. Starts from the opening balance and adds each transaction to show a running balance.  
**Chart:** None (table only)  
**Date scope:** Current month  
**Notes:** Hard-codes `ACCOUNTID = 1`. Uses a recursive CTE to resolve category hierarchies.

---

### AhorroGastos
**Folder:** `AhorroGastos/`  
**Purpose:** Savings vs. expenses comparison.  
**Files:** SQL only (no template or JS yet — work in progress)

---

### IngresosPasivos
**Folder:** `IngresosPasivos/`  
**Purpose:** Advanced passive income and investment portfolio dashboard. Tracks income sources, computes XIRR (Newton-Raphson), TAE (annual equivalent rate), and per-stock performance. Includes year filter (2024/2025/2026).  
**Chart:** Custom canvas-based XY chart (no external lib)  
**Layout:** CSS grid dashboard with cards (col-1 to col-12 system)  
**Files:** `plantilla.html`, `dashboard.html`, `data.js`  
**Notes:** Most complex report. Data is embedded in `data.js`. Multiple views: summary card, stock-by-stock table, portfolio detail.

---

### PasiveIncomes
**Folder:** `PasiveIncomes/`  
**Purpose:** Simpler passive income report with date filtering and an XY line chart. Shows income records in a sortable table with a running total and cumulative chart.  
**Chart:** amCharts 5 — XY Line chart  
**Date scope:** Selectable: all / last year / this year / this quarter / last month / this month  
**Files:** `index.html`, `script.js`

---

## Tech Stack Summary

| Layer | Technology |
|-------|-----------|
| Data source | MMEX SQLite database |
| Query language | SQLite SQL |
| Frontend | Vanilla HTML + JS |
| Charts | amCharts 4 (older reports), amCharts 5 (newer reports) |
| Styling | `master.css` (provided by MMEX at runtime) |
