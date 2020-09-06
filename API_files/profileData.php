<?php 
$username = "root";
$password = "";
$server ="127.0.0.1";
$db="flutter";

$con = mysqli_connect($server,$username,$password,$db);
if($con){
$userid=$_GET['userid'];
    $selectQuery="select * from user where id='$userid'" ;
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