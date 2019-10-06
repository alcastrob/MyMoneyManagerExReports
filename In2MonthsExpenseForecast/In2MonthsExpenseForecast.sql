
    SELECT c.TRANSID AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory, c.TRANSDATE AS Moment, c.TOTRANSAMOUNT AS Ammount, c.Status AS Status, 1 AS Section
    FROM CHECKINGACCOUNT_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND c.Status != "V"
        AND Moment >= date("now", "start of month", "+2 month")
        AND Moment <= date("now", "start of month", "+3 month", "-1 day")
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory, c.TRANSDATE AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment >= date("now", "start of month", "+2 month")
        AND Moment <= date("now", "start of month", "+3 month", "-1 day")
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes,
        cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        CASE
            WHEN strftime("%d", c.TRANSDATE) >= strftime("%d", date("now")) THEN date(c.TRANSDATE, "+2 month")
            ELSE date(c.TRANSDATE, "+1 month")
        END AS Moment,
        c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND c.TRANSDATE <= date("now", "start of month", "+2 month", "-1 day")
        AND c.REPEATS IN (3, 103, 203)
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        date(c.TRANSDATE, "+2 month", "start of month", "weekday " || strftime("%w", c.TRANSDATE), "+0 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+3 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        date(c.TRANSDATE, "+2 month", "start of month", "weekday " || strftime("%w", c.TRANSDATE), "+7 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+3 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        date(c.TRANSDATE, "+2 month", "start of month", "weekday " || strftime("%w", c.TRANSDATE), "+14 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+3 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        date(c.TRANSDATE, "+2 month", "start of month", "weekday " || strftime("%w", c.TRANSDATE), "+21 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+3 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, cat2.SUBCATEGNAME AS Subcategory,
        date(c.TRANSDATE, "+2 month", "start of month", "weekday " || strftime("%w", c.TRANSDATE), "+28 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CATEGORY_V1 cat ON cat.CATEGID = c.CATEGID
        LEFT JOIN SUBCATEGORY_V1 cat2 ON cat2.SUBCATEGID = c.SUBCATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+3 month","-1 day")
        AND Repeats = 1

ORDER BY Section, Moment