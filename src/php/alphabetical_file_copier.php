#!/usr/bin/php -q
<?php
#########################
##
## Config
##
#########################
$debug=false;

define ("OS_S","/");

#########################
##
## end of config
##
#########################



if(isset($_SERVER["argv"][1]) && isset($_SERVER["argv"][2])){

move_dirs($_SERVER["argv"][1],$_SERVER["argv"][2],$_SERVER["argv"][1],"copy",-1);

}elseif(isset($_SERVER["argv"][1])){

move_dirs($_SERVER["argv"][1],null,$_SERVER["argv"][1],"move",-1);
recursive_remove_directory($_SERVER["argv"][1]);
	if(substr($_SERVER["argv"][1],-1) == OS_S){ 
		$directory = substr($_SERVER["argv"][1],0,-1);
	}
rename($directory."_tmp",$_SERVER["argv"][1]);


}else{

print_help();
}


function print_help(){
    echo "\n";
    echo "alphabetical_file_copier V 0.1 Copyright (c) 2010 Andrés Bott   26 Jul 2010\n";
    echo "\n";
    echo "\n";
    echo "Usage     alphabetical_file_copier <origin> (<destination>)\n";
    echo "\n";
    echo "Exapmple usage:\n";
    echo "   alphabetical_file_copier <folder>  to move al files in alphabetical order to a temp folder, and then rename it to the original name\n";
    echo "   alphabetical_file_copier <folder>  <folder> to copy al files in alphabetical order to destination folder\n";
    echo "\n";
}




function move_dirs($directory,$destino,$starfolder,$action=null,$sublevels=0){

if($action=="copy" || $action == "move"){

  global $debug;








	// remove the Os separator from the url string
	if(substr($directory,-1) == OS_S){ 
		$directory = substr($directory,0,-1);
	}
	// remove the Os separator from the url string
	if(substr($destino,-1) == OS_S){ 
		$destino = substr($destino,0,-1);
	}

if($destino==null){
  $destino=$directory."_tmp";
}
  safe_create_dir($destino);



	if(!file_exists($directory) || !is_dir($directory)){
		return FALSE;
	}elseif(is_readable($directory)){
		$directory_list = opendir($directory);
		$i=0;
		while($file = readdir($directory_list)){
		      
		      $narray[$i]=$directory.OS_S.$file;
		      $i++;
		}
	}

	$count_array=count($narray);
      
	sort($narray);




	for($i=0;$i<$count_array;$i++){
	      $file = explode(OS_S,$narray[$i]);
 
	      $file = end($file);


 	      if($file != '.' && $file != '..' && substr($file,0,1) != '.' && substr($file,-1)!= "~"){
		      
			
			
			$path = $directory.OS_S.$file;

				if(is_readable($path)){

// 					$subdirectories = explode('OS_S',$path);
	 				if(is_dir($path)){  // is a dir

						if($sublevels != 0){
							if ($sublevels > 0){
								$retsublevels=$sublevels-1;
							}elseif($sublevels==-1){
								$retsublevels=$sublevels;
							}


				      if($action=="copy"){
					echo "\nCopiando Directorio: ";
				      }elseif("move"){
					echo "\nMoviendo Directorio: ";
				      }
				    

				  $directory2=substr($directory, strlen($starfolder)); 	
				if(empty($directory2)){
				  echo $destino.OS_S.$file;
				  safe_create_dir($destino.OS_S.$file);
				    }else{
				echo $destino.OS_S.$directory2.OS_S.$file;
				  safe_create_dir($destino.OS_S.$directory2.OS_S.$file);

				    }


						move_dirs($path,$destino,$starfolder,$action,$retsublevels);
						}
				
					}elseif(is_file($path)){ // is a fileç

					    $directory2=substr($directory, strlen($starfolder)); 
					    $archivo_origen = addcslashes($directory.OS_S.$file,"");
					    $archivo_destino = addcslashes($destino.OS_S.$directory2.OS_S.$file,"");

// 					      echo "file: ".$archivo_origen;


						if($action=="copy"){
						    if (!copy($archivo_origen,$archivo_destino )) {
							echo "Error al Copiar archivo: $archivo_origen...\n";
						    }else{
							if($debug==true){
								echo "Archivo copiado a: ".$archivo_destino;
								echo "\n";
							}else{
							    echo ".";
							}
						    }

						}elseif($action=="move"){
						    if (!rename($archivo_origen,$archivo_destino )) {
							  echo "Error al Mover archivo: $archivo_origen...\n";
						    }else{
							if($debug==true){
								echo "Archivo movido a: ".$archivo_destino;
								echo "\n";
							}else{
							    echo ".";
							}
						    }
						 }






// 				echo $destino.OS_S.$directory2.OS_S.$file;

					}
				}
    
 	      }

// 	    echo $narray[$i]."\n";
	}// end of for







}
}


function safe_create_dir($dir){
	if(is_dir($dir)&& is_writable($dir)){
		return true;
	}
	if(!is_dir($dir)&& is_writable("./")){
		if(!mkdir($dir)) {
  			die('Failed to create folders...');
		}else{
			return true;
		}
	}else{
		die("Failed to create folders, check permissions");
	}
}

// ------------ lixlpixel recursive PHP functions -------------
// recursive_remove_directory( directory to delete, empty )
// expects path to directory and optional TRUE / FALSE to empty
// ------------------------------------------------------------
function recursive_remove_directory($directory, $empty=FALSE){
    if(substr($directory,-1) == '/'){
        $directory = substr($directory,0,-1);
    }
     if(!file_exists($directory) || !is_dir($directory))
     {
        return FALSE;
     }elseif(is_readable($directory))
    {
        $handle = opendir($directory);
        while (FALSE !== ($item = readdir($handle)))
        {
            if($item != '.' && $item != '..')
            {
                $path = $directory.'/'.$item;
                if(is_dir($path)) 
                 {
                    recursive_remove_directory($path);
                 }else{
                    unlink($path);
                }
            }
        }
        closedir($handle);
        if($empty == FALSE)
        {
             if(!rmdir($directory))
            {
                return FALSE;
            }
        }
    }
    return TRUE;
}
 // ------------------------------------------------------------


						  echo "\n";
						  echo "\n";
?>
