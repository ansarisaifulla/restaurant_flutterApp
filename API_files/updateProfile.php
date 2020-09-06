<?php 
$username = "root";
$password = "";
$server ="127.0.0.1";
$db="flutter";

$con = mysqli_connect($server,$username,$password,$db);
if($con){
$userid=$_POST['userid'];
$username = $_POST['name'];
    $email = $_POST['email'];
    $mobile = $_POST['mobile'];
$address=$_POST['address'];
    $updateQuery="update user set name='$username',email='$email',address='$address',mobile='$mobile' where id='$userid'" ;
	$result=$con->query($updateQuery);
			if($result)
			{
				 $con->close();
				echo "updated successfully";	
			}
			else
			{ $con->close();
				echo "could not update";
			}
           
}
else
{
    echo "database connection failed";
}

?>