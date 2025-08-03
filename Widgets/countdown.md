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

        // Set the target date to April 2nd, 2027
        const targetDate = new Date('2027-04-02');

        // Calculate the difference in time
        const diffTime = targetDate - now;

        // Convert time difference from milliseconds to days
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        // Display the result
        document.write(`${diffDays} days remaining`);
    })();
</script>
