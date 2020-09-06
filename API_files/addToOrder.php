<?php 
$username="root";
$password="";
$db="flutter";
$server="127.0.0.1";

$con=mysqli_connect($server,$username,$password,$db);
if($con)
{
  
  $userid=$_POST['userid'];
  $foodid=$_POST['foodid'];



  $insertQuery="insert into order(userid,foodid) values ('$userid','$foodid')";
           
            $result=mysqli_query($con,$insertQuery);
            if($result)
            {
                echo "Item added to order";
            }
            else
            {
            	 echo "could not add to order";

            }
  
}
else
{
	echo "database connection failed";
}

?>