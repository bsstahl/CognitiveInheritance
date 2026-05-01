---
id: ab32912a-93ac-4107-84b5-ecc5dfd8e3d9
title: Countdown
showtitle: true
showinsidebar: false
widgettype: TextBox
orderindex: 13

---
<script>
    (function() {
        const now = new Date();

        // Set the target date to April 2nd, 2034 - my 67th birthday
        // Which is Full Retirement Age (FRA) for those born after 1960
        // https://www.ssa.gov/benefits/retirement/planner/1960.html
        const targetDate = new Date('2034-10-02');

        // Calculate the difference in time
        const diffTime = targetDate - now;

        // Convert time difference from milliseconds to days
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        // Display the result
        document.write(`${diffDays} days remaining`);
    })();
</script>
