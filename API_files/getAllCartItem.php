<?php 
$username="root";
$password="";
$db="flutter";
$server="127.0.0.1";

$con=mysqli_connect($server,$username,$password,$db);
if($con)
{

	$userid=$_GET['userid'];
  $selectQuery="select f.id,c.id as cartid,f.name,f.imagepath,f.category,f.price,f.discount,f.description,c.quantity
                from fooditem f inner join cart c on f.id=c.foodid 
                where f.id in (select foodid from cart  where userid='$userid')";

           
            $result=mysqli_query($con,$selectQuery);
		$response=array();
            if($result->num_rows>0)
            {
		while($row=$result->fetch_assoc())
		{
			array_push($response,$row);
		}
                
            }
	header('Content-Type: application/json');
	echo json_encode($response);
}
else
{
	echo "database connection failed";
}

?>