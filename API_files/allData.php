<?php 
$username = "root";
$password = "";
$server ="127.0.0.1";
$db ="crud_mysql";

$con = mysqli_connect($server,$username,$password,$db);
if($con){
    $selectQuery="select * from flutter_table" ;
	$result=$con->query($selectQuery);
	$response=array();
			if($result->num_rows>0)
			{
				
				while($row=$result->fetch_assoc())
				{
					array_push($response,$row);
				}
			}
            $con->close();
            header('Content-Type: application/json');
            echo json_encode($response);
	
}
else
{
    echo "database connection failed";
}

?>