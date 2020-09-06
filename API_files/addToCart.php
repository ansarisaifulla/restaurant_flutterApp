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
  $quantity=$_POST['quantity'];
  $checkQuery="select * from cart where userid='$userid' and foodid='$foodid' and quantity='$quantity'";
  $secondCheckQuery="select * from cart where userid='$userid' and foodid='$foodid' and quantity!='$quantity'";
	$query=mysqli_query($con,$checkQuery);
	$check_query_count=mysqli_num_rows($query);

        $secondQuery=mysqli_query($con,$secondCheckQuery);
	$second_check_query_count=mysqli_num_rows($secondQuery);
	if($check_query_count>0)
	{
          echo "Item already added in cart";
	}
	else if($second_check_query_count>0)
	{
	  $updateQuery="update cart set quantity='$quantity' where userid='$userid' and foodid='$foodid'";
           
            $result=mysqli_query($con,$updateQuery);
            if($result)
            {
                echo "Item updated to cart";
            }
            else
            {
            	 echo "Sorry could add to cart";

            }
	}
	else{
	
	$insertQuery="insert into cart(userid,foodid,quantity) values ('$userid','$foodid','$quantity')";
           
            $result=mysqli_query($con,$insertQuery);
            if($result)
            {
                echo "Item added to cart";
            }
            else
            {
            	 echo "Sorry could add to cart";

            }
	}
  	
  
}
else
{
	echo "database connection failed";
}

?>