<?php 
$username="root";
$password="";
$db="flutter";
$server="127.0.0.1";

$con=mysqli_connect($server,$username,$password,$db);
if($con)
{
  $id=$_GET['id'];
	$deleteQuery = "delete from cart where id='$id'";
	$query = mysqli_query($con,$deleteQuery);
  	if($query)
	{echo "Item removed";
	}
	else
	{echo "could not remove item";
	}
}
else
{
	echo "database connection failed";
}

?>
