SELECT Category, SUM(Ammount) AS Ammount, SUM(Percentage) AS Percentage, StartDate
FROM (
        SELECT cat.CATEGNAME AS Category,
      ROUND(SUM(c.TOTRANSAMOUNT) * -1, 2) AS Ammount,
      ROUND(SUM(c.TOTRANSAMOUNT) * 100 / (
    SELECT SUM(Ammount) AS Ammount
      FROM (
      SELECT c.TOTRANSAMOUNT AS Ammount
        FROM CHECKINGACCOUNT_V1 c
        WHERE c.TRANSCODE = "Deposit"
          AND c.Status != "V"
          AND c.TRANSDATE >= date("now","localtime", "start of month", "-2 months")
          AND c.TRANSDATE <= date("now","localtime", "start of month", "-1 months")
    )), 2) AS Percentage,
      date("now","localtime", "start of month", "-2 months") AS StartDate
    FROM CHECKINGACCOUNT_V1 c
      LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
      LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE c.TRANSCODE = "Withdrawal"
      AND c.Status != "V"
      AND c.TRANSDATE >= date("now","localtime", "start of month")
      AND c.TRANSDATE <= date("now","localtime")
      AND c.CATEGID != -1
    GROUP BY cat.CATEGNAME
  UNION
    SELECT cat.CATEGNAME AS Category,
      ROUND(SUM(spl.SPLITTRANSAMOUNT) * -1, 2) AS Ammount,
      ROUND(SUM(spl.SPLITTRANSAMOUNT) * 100 / (
    SELECT SUM(Ammount) AS Ammount
      FROM (
      SELECT c.TOTRANSAMOUNT AS Ammount
        FROM CHECKINGACCOUNT_V1 c
        WHERE c.TRANSCODE = "Deposit"
          AND c.Status != "V"
          AND c.TRANSDATE >= date("now","localtime", "start of month", "-2 months")
          AND c.TRANSDATE <= date("now","localtime", "start of month", "-1 months")
    )), 2) AS Percentage,
      date("now","localtime", "start of month", "-2 months") AS StartDate
    FROM CHECKINGACCOUNT_V1 c
      INNER JOIN SPLITTRANSACTIONS_V1 spl ON spl.TRANSID = c.TRANSID
      LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = spl.CATEGID
      LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = spl.SUBCATEGID
    WHERE c.TRANSCODE = "Withdrawal"
      AND c.Status != "V"
      AND c.TRANSDATE >= date("now","localtime", "start of month")
      AND c.TRANSDATE <= date("now","localtime")
      AND c.CATEGID = -1
    GROUP BY cat.CATEGNAME
  UNION
    SELECT "Total Gastos" AS Category,
      ROUND(SUM(c.TOTRANSAMOUNT) * -1, 2) AS Ammount,
      ROUND(SUM(c.TOTRANSAMOUNT) * 100 / (
      SELECT SUM(Ammount) AS Ammount
      FROM (
      SELECT c.TOTRANSAMOUNT AS Ammount
        FROM CHECKINGACCOUNT_V1 c
        WHERE c.TRANSCODE = "Deposit"
          AND c.Status != "V"
          AND c.TRANSDATE >= date("now","localtime", "start of month", "-2 months")
          AND c.TRANSDATE <= date("now","localtime", "start of month", "-1 months")
      )), 2) AS Percentage,
      date("now","localtime", "start of month", "-1 months") AS StartDate
    FROM CHECKINGACCOUNT_V1 c
    WHERE c.TRANSCODE = "Withdrawal"
      AND c.Status != "V"
      AND c.TRANSDATE >= date("now","localtime", "start of month")
      AND c.TRANSDATE <= date("now","localtime")

)
GROUP BY Category, StartDate
ORDER BY 2