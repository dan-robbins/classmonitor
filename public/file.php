<?php
header('Content-Type: application/json');

$aResult = array();

if( !isset($_POST['functionname']) ) {
	$aResult['error'] = 'No function name!';
}

if( !isset($_POST['arguments']) ) {
	$aResult['error'] = 'No function arguments!';
}

if( !isset($aResult['error']) ) {
    switch($_POST['functionname']) {
        case 'loadurl':
            if( !is_array($_POST['arguments']) || (count($_POST['arguments']) < 2) ) {
                $aResult['error'] = 'Error in arguments!';
            }
            else {
				$url = "https://app.testudo.umd.edu/soc/search?courseId={$_POST['arguments'][0]}&sectionId={$_POST['arguments'][1]}&termId=201901&creditCompare=&credits=&courseLevelFilter=ALL&instructor=&_facetoface=on&_blended=on&_online=on&courseStartCompare=&courseStartHour=&courseStartMin=&courseStartAM=&courseEndHour=&courseEndMin=&courseEndAM=&teachingCenter=ALL&_classDay1=on&_classDay2=on&_classDay3=on&_classDay4=on&_classDay5=on"
				if(is_callable( 'curl_init' )) {
					$ch = curl_init();
					curl_setopt($ch, CURLOPT_HEADER, 0);
					curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
					curl_setopt($ch, CURLOPT_URL, $url);
					$data = curl_exec($ch);
					curl_close($ch);
				}
				if( empty($data) || !is_callable('curl_init') ) {
					$opts = array('http'=>array('header' => 'Connection: close'));
					$context = stream_context_create($opts);
					$headers = get_headers($url);
					$httpcode = substr($headers[0], 9, 3);
					if( $httpcode == '200' )
						$data = file_get_contents($url, false, $context);
					else{
						$data = '{"div":"Error ' . $httpcode . ': Invalid Url<br />"}';
					}
				}

                $aResult['result'] = $data;
            }
            break;

        default:
            $aResult['error'] = 'Not found function '.$_POST['functionname'].'!';
            break;
    }
}

echo json_encode($aResult);
?>
