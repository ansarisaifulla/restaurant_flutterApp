<?php 
$username = "root";
$password = "";
$server ="127.0.0.1";
$db="flutter";

$con = mysqli_connect($server,$username,$password,$db);
if($con){
    $username = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['mobile'];
    $pass = $_POST['password'];
    //$confirm = $_POST['confirm'];

    $passSafe = password_hash($pass, PASSWORD_BCRYPT);
    // $cpassSafe = password_hash($confirm, PASSWORD_BCRYPT);

    $emailQuery = "select * from user where email= '$email'";
    $query = mysqli_query($con,$emailQuery);
    $emailcount = mysqli_num_rows($query);
    if($emailcount > 0)
    {
        echo "Email already exist";
    }
    else
    {

        
            $insertQuery="insert into user (name, email, mobile, password,address) values ('$username','$email','$phone','$passSafe','pune')";
            $result=mysqli_query($con,$insertQuery);
            if($result)
            {
                echo "Data registered succcessfully";
            }
            else
            {
                echo "Data not registered";
            }
        // }
        
    }

	
}
else
{
    echo "oops database connection failed";
}

?>