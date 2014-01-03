<!DOCTYPE html>
<html lang="en">
    <head>
    	<meta charset="utf-8">
	</head>
	<body>
		<?php
			include 'database.php';

			$result = mysql_query("SELECT * FROM Popularity ORDER BY Changes DESC");

			echo "<table border=\"1\">
				<tr>
					<th>Station name</th>
					<th>Number of bike additions/removals</th>
					<th>Date/time of last addition/removal</th>
				</tr>";

			while ($row = mysql_fetch_array($result))
			{
				echo "<tr>";
				echo "<td><a href=\"http://maps.google.com/?q=" . $row["Latitude"] . "," . $row["Longitude"] . "\">" . $row["Name"] . "</a></td>";
				echo "<td>" . $row["Changes"] . "</td>";
				echo "<td>" . $row["TimeDateChanged"] . "</td>";
				echo "</tr>";
			}

			echo "</table>";
		?>
	</body>
</html>