<?php ini_set( "display_errors", 0); 

require_once("dbcon.php");

$method 	 = $_SERVER['REQUEST_METHOD'];
$input 		 = json_decode(file_get_contents('php://input'),true);

if (($method=='POST') && !empty($input['nama']) && !empty($input['nohp'])){
	
	$nama 	= mysqli_escape_string($con,$input['nama']);
	$nohp 	= mysqli_escape_string($con,$input['nohp']);
	
	$sql = "INSERT INTO contact (id,nama,nohp) VALUES ('','".$nama."','".$nohp."')";
										
	if (!mysqli_query($con,$sql)) { 			
		
		$out_fail 	= json_encode(array("Status"=>"FAIL", "Respon"=>"Simpan Contact Gagal!"));		
		echo $out_fail;
	
	} else {
		
		$out_sukses = json_encode(array("Status"=>"DONE", "Respon"=>"Simpan Contact Sukses!"));
		echo $out_sukses;
		
	}
				
} else {
	
	$out_fail 	= json_encode(array("Status"=>"FAIL", "Respon"=>"Empty Parameter!"));		
	echo $out_fail;
	
}

?>